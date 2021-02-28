import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otsappmobile/constants.dart';

class FirestoreService {
  saveUserIsNotExist(String name, String photoUrl, {int userId}) {
    var userRef = FirebaseFirestore.instance.collection('users');
    userRef.where("userId", isEqualTo: userId ?? sUserID).get().then(
          (value) => {
            if (value.docs.length == 0)
              userRef.doc().set(
                {
                  "userId": userId ?? sUserID,
                  "name": name,
                  "photoURL": photoUrl,
                },
              )
            else
              userRef.doc(value.docs.first.id).update(
                {
                  "online":true
                },
              )
          },
        );
  }

  Future<FrChat> getChat(String chatDocId) async {
    return await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatDocId)
        .get()
        .then((value) => FrChat.fromSnapshot2(value.id, value.data()));
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

  // loadUserByUserId(int userId) async {
  //   if (sFrUsers?.singleWhere((x) => x.userId == userId, orElse: () => null) == null) {
  //     var tmp = await FirebaseFirestore.instance
  //         .collection("users")
  //         .where("userId", isEqualTo: userId)
  //         .limit(1)
  //         .get()
  //         .then((value) => value.docs);
  //     if (tmp.length > 0) {
  //       var user = FrUser.fromSnapshot(tmp.first);
  //       sFrUsers ??= List();
  //       sFrUsers.add(user);
  //     }
  //   }
  // }

  // Future<List<FrChat>> getUserChats() async {
  //   var db = FirebaseFirestore.instance;
  //   var chatsRef = db.collection("chats").where("members", arrayContains: sUserID);
  //   var chats = await chatsRef.get();
  //   var chatList = frChatFromSnapshot(chats.docs);
  //   for (var item in chatList) {
  //     for (var item2 in item.members) {
  //       await loadUserByUserId(item2);
  //     }
  //   }
  //   return chatList;
  // }

  Stream<QuerySnapshot> getStreamUserChats() {
    var db = FirebaseFirestore.instance;
    var chatsRef =
        db.collection("chats").where("members", arrayContains: sUserID);
    return chatsRef.snapshots();
    // var chatsRef = db.collection("chats").where("members", arrayContains: sUserID);
    // var chats = await chatsRef.get();
    // var chatList = frChatFromSnapshot(chats.docs);
    // for (var item in chatList) {
    //   for (var item2 in item.members) {
    //     await loadUserByUserId(item2);
    //   }
    // }
    // return chatList;
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
  });

  String documentId;
  DateTime lastMessageDate;
  String lastMessage;
  List<int> members;

  factory FrChat.fromSnapshot(DocumentSnapshot snapshot) {
    return FrChat(
      documentId: snapshot.id,
      lastMessageDate: (snapshot["lastMessageDate"] as Timestamp).toDate(),
      lastMessage: snapshot["lastMessage"],
      members: List.from(snapshot["members"]),
    );
  }
  factory FrChat.fromSnapshot2(String id, Map<String, dynamic> snapshot) {
    return FrChat(
      documentId: id,
      lastMessageDate: (snapshot["lastMessageDate"] as Timestamp).toDate(),
      lastMessage: snapshot["lastMessage"],
      members: List.from(snapshot["members"]),
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
  FrMessage({this.documentId, this.message, this.read, this.sender, this.date});

  String documentId, message;
  bool read;
  int sender;
  DateTime date;

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
        date: (snapshot["date"] as Timestamp).toDate());
  }
}
