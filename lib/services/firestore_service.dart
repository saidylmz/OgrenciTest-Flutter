import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:otsappmobile/constants.dart';

class FirestoreService {
  saveUserIsNotExist(String name, String photoUrl,
      {int userId, bool uploadPhoto}) async {
    if (uploadPhoto != null && uploadPhoto) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      var uploadTask =
          reference.putString(photoUrl, format: PutStringFormat.base64);
      var storageTaskSnapshot = await uploadTask;
      photoUrl = await storageTaskSnapshot.ref.getDownloadURL();
    }
    var userRef = FirebaseFirestore.instance.collection('users');
    int uId = userId == null ? sUserID : userId;
    userRef.where("userId", isEqualTo: uId).get().then(
          (value) => {
            if (value.docs.length == 0)
              userRef.doc().set(
                {
                  "userId": userId ?? sUserID,
                  "name": name,
                  "photo": photoUrl,
                  "online": false,
                  "token": userId == null ? sNotifToken : "",
                  "device": Platform.operatingSystem
                },
              )
            else if (userId == null)
              userRef.doc(value.docs.first.id).update(
                {
                  "online": true,
                  "token": userId == null ? sNotifToken : "",
                  "device": Platform.operatingSystem
                },
              )
          },
        );
  }

  updateImage(String photoUrl, {bool uploadPhoto}) async {
    if (uploadPhoto != null && uploadPhoto) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      var uploadTask =
          reference.putString(photoUrl, format: PutStringFormat.base64);
      var storageTaskSnapshot = await uploadTask;
      photoUrl = await storageTaskSnapshot.ref.getDownloadURL();
    }
    var userRef = FirebaseFirestore.instance.collection('users');
    userRef.where("userId", isEqualTo: sUserID).get().then(
          (value) => {
            userRef.doc(value.docs.first.id).update(
              {
                "photo": photoUrl,
              },
            )
          },
        );
  }

  Future<String> getUserToken(int userId) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) => value.docs.first.data()["token"] ?? "");
  }

  setOffline() {
    var userRef = FirebaseFirestore.instance.collection('users');
    userRef.where("userId", isEqualTo: sUserID).get().then((value) {
      userRef.doc(value.docs.first.id).update(
        {"online": false},
      );
    });
  }

  Future<FrChat> getChat(String chatDocId) async {
    return await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatDocId)
        .get()
        .then((value) => FrChat.fromSnapshot2(value.id, value.data()));
  }

  Future<String> isChatDeleted(int userId) async {
    return FirebaseFirestore.instance
        .collection("chats")
        .where("members", arrayContains: sUserID)
        .get()
        .then((doc) {
      var data = doc.docs.where((element) {
        var chat = FrChat.fromSnapshot(element);
        return chat.deletedMembers.contains(sUserID) &&
            chat.members.contains(userId);
      });
      if (data.length > 0) {
        var chat = FrChat.fromSnapshot(data.first);
        FirebaseFirestore.instance
            .collection("chats")
            .doc(chat.documentId)
            .update({"deletedMembers": []});
        return chat?.documentId ?? null;
      }
      return null;
    });
  }

  Future<List<FrUser>> getUsers(List<int> userIds) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("userId", whereIn: userIds)
        .get()
        .then((value) => value.docs
            .map((e) => FrUser.fromSnapshot2(e.id, e.data()))
            .toList());
  }

  Stream<QuerySnapshot> getUnreadMessageCount(String chatId) {
    return FirebaseFirestore.instance
        .collection("messages")
        .doc(chatId)
        .collection(chatId)
        .where("sender", isNotEqualTo: sUserID)
        .snapshots();
  }

  Stream<QuerySnapshot> getStreamUserChats() {
    var db = FirebaseFirestore.instance;
    var chatsRef =
        db.collection("chats").where("members", arrayContains: sUserID);
    return chatsRef.snapshots();
  }

  Future<int> getAllUnreadMessageCount() async {
    var db = FirebaseFirestore.instance;
    int count = 0;
    var chats = await db
        .collection("chats")
        .where("members", arrayContains: sUserID)
        .get();
    for (var item in chats.docs) {
      count += await db
          .collection("messages")
          .doc(item.id)
          .collection(item.id)
          .where("sender", isNotEqualTo: sUserID)
          .get()
          .then((value) => value.docs
              .where((element) => element.data()["read"] == false)
              .length);
    }
    return count;
  }
}

List<FrChat> frChatFromSnapshot(List<DocumentSnapshot> snapshot) =>
    List<FrChat>.from(snapshot.map((x) => FrChat.fromSnapshot(x)));

class FrChat {
  FrChat({
    this.documentId,
    this.lastMessageDate,
    this.lastMessage,
    this.members,
    this.deletedMembers,
  });

  String documentId;
  DateTime lastMessageDate;
  String lastMessage;
  List<int> members, deletedMembers;

  factory FrChat.fromSnapshot(DocumentSnapshot snapshot) {
    return FrChat(
      documentId: snapshot.id,
      lastMessageDate: (snapshot["lastMessageDate"] as Timestamp).toDate(),
      lastMessage: snapshot["lastMessage"],
      members: List.from(snapshot["members"]),
      deletedMembers: snapshot["deletedMembers"] != null
          ? List.from(snapshot["deletedMembers"])
          : [],
    );
  }
  factory FrChat.fromSnapshot2(String id, Map<String, dynamic> snapshot) {
    return FrChat(
      documentId: id,
      lastMessageDate: (snapshot["lastMessageDate"] as Timestamp).toDate(),
      lastMessage: snapshot["lastMessage"],
      members: List.from(snapshot["members"]),
      deletedMembers: snapshot["deletedMembers"] != null
          ? List.from(snapshot["deletedMembers"])
          : [],
    );
  }
}

class FrUser {
  FrUser({this.documentId, this.name, this.online, this.photo, this.userId});

  String documentId, photo, name;
  bool online;
  int userId;

  factory FrUser.fromSnapshot(DocumentSnapshot snapshot) {
    return FrUser(
        documentId: snapshot.id,
        name: snapshot["name"],
        photo: snapshot["photo"],
        online: snapshot["online"],
        userId: snapshot["userId"]);
  }
  factory FrUser.fromSnapshot2(String id, Map<String, dynamic> snapshot) {
    return FrUser(
        documentId: id,
        name: snapshot["name"],
        photo: snapshot["photo"],
        online: snapshot["online"],
        userId: snapshot["userId"]);
  }
}

class FrMessage {
  FrMessage(
      {this.documentId,
      this.message,
      this.read,
      this.sender,
      this.date,
      this.type});

  String documentId, message;
  bool read;
  int sender;
  DateTime date;
  int type;

  // factory FrMessage.fromSnapshot(DocumentSnapshot snapshot) {
  //   return FrMessage(
  //       documentId: snapshot.id,
  //       name: snapshot["name"],
  //       photo: snapshot["photo"],
  //       online: snapshot["online"],
  //       userId: snapshot["userId"]);
  // }
  factory FrMessage.fromSnapshot2(String id, Map<String, dynamic> snapshot) {
    return FrMessage(
        documentId: id,
        message: snapshot["message"],
        read: snapshot["read"],
        sender: snapshot["sender"],
        date: (snapshot["date"] as Timestamp).toDate(),
        type: snapshot["type"]);
  }
}
