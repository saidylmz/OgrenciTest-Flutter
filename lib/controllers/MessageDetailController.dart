import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/services/firestore_service.dart';
import 'package:otsappmobile/services/notification_service.dart';

class SendMenuItems {
  String text;
  IconData icons;
  MaterialColor color;
  int type;
  SendMenuItems(
      {@required this.text,
      @required this.icons,
      @required this.color,
      @required this.type});
}

class MessageDetailController extends ControllerMVC {
  bool isShowSticker = false;

  MessageDetailController([StateMVC state]) : super(state);
  final ScrollController listScrollController = ScrollController();
  TextEditingController inputController = TextEditingController();
  String chatId;
  String inputText;
  FrChat chat;
  List<FrUser> toUser = List();

  loadChatInfo(String chatId) async {
    chatId = chatId;
    chat = await FirestoreService().getChat(chatId);
    chat.members = chat.members.where((element) => element != sUserID).toList();
    toUser = await FirestoreService().getUsers(chat.members);
    setState(() {});
    FirebaseFirestore.instance
        .collection("messages")
        .doc(chatId)
        .collection(chatId)
        .where("sender", isNotEqualTo: sUserID)
        .get()
        .then((value) {
      value.docs
          .where((element) => element.data()["read"] == false)
          .forEach((item) {
        item.reference.update({"read": true});
      });
    });
  }

  loadNewChat(int userId) async {
    toUser = await FirestoreService().getUsers([userId]);
    setState(() {});
  }

  sendMessage(String content, int type) async {
    var frInstance = FirebaseFirestore.instance;
    var reference =
        frInstance.collection("messages").doc(chatId).collection(chatId).doc();
    frInstance.runTransaction((transaction) async {
      transaction.set(
        reference,
        {
          'read': false,
          'message': content,
          'date': Timestamp.now(),
          'sender': sUserID,
          'type': type
        },
      );
    });
    var reference2 = frInstance.collection("chats").doc(chatId);
    frInstance.runTransaction((transaction) async {
      transaction.update(
        reference2,
        {
          'lastMessage': content,
          'lastMessageDate': Timestamp.now(),
        },
      );
    });
    String token = await FirestoreService().getUserToken(toUser.first.userId);
    if (type == 0)
      NotificationService().pushNotification(token, toUser.first.name, content);
    else if (type == 1)
      NotificationService().pushNotification(
          token, toUser.first.name, "Fotoğraf",
          imageUrl: content);
    else
      NotificationService()
          .pushNotification(token, toUser.first.name, "Sticker");
  }

  void sendMessageFirst(String content, int type) async {
    var frInstance = FirebaseFirestore.instance;
    var reference2 = frInstance.collection("chats").doc();
    frInstance.runTransaction((transaction) async {
      transaction.set(
        reference2,
        {
          'lastMessage': content,
          'lastMessageDate': Timestamp.now(),
          'members': [sUserID, toUser.first.userId],
          'deleteMembers': []
        },
      );
    });
    chatId = reference2.id;
    var reference =
        frInstance.collection("messages").doc(chatId).collection(chatId).doc();
    frInstance.runTransaction((transaction) async {
      transaction.set(
        reference,
        {
          'read': false,
          'message': content,
          'date': Timestamp.now(),
          'sender': sUserID,
          'type': type
        },
      );
    });

    chat = FrChat(
        lastMessage: content,
        documentId: chatId,
        lastMessageDate: Timestamp.now().toDate(),
        deletedMembers: [],
        members: [sUserID, toUser.first.userId]);
    setState(() {});

    String token = await FirestoreService().getUserToken(toUser.first.userId);
    if (type == 0)
      NotificationService().pushNotification(token, toUser.first.name, content);
    else if (type == 1)
      NotificationService().pushNotification(
          token, toUser.first.name, "Fotoğraf",
          imageUrl: content);
    else
      NotificationService()
          .pushNotification(token, toUser.first.name, "Sticker");
  }

  File imageFile;
  String imageUrl;
  Future getImage(bool fromGallery) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        uploadFile();
      }
    }
  }

  List<SendMenuItems> menuItems = [
    SendMenuItems(
        text: "Kamera", icons: Icons.camera_alt, color: Colors.blue, type: 0),
    SendMenuItems(
        text: "Resim", icons: Icons.image, color: Colors.amber, type: 1),
    SendMenuItems(
        text: "Sticker",
        icons: Icons.sticky_note_2,
        color: Colors.orange,
        type: 2),
    // SendMenuItems(text: "Audio", icons: Icons.music_note, color: Colors.orange),
    // SendMenuItems(text: "Location", icons: Icons.location_on, color: Colors.green),
    // SendMenuItems(text: "Contact", icons: Icons.person, color: Colors.purple),
  ];

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    var uploadTask = reference.putFile(imageFile);
    var storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        if (chatId != null)
          sendMessage(imageUrl, 1);
        else
          sendMessageFirst(imageUrl, 1);
      });
    }, onError: (err) {
      // setState(() {
      //   isLoading = false;
      // });
      //Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  Future<bool> backPress(BuildContext context) {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  List<String> stickers = [
    "mimi1.gif",
    "mimi2.gif",
    "mimi3.gif",
    "mimi4.gif",
    "mimi5.gif",
    "mimi6.gif",
    "mimi7.gif",
    "mimi8.gif",
    "mimi9.gif"
  ];

  Widget buildSticker(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Wrap(
            runSpacing: 15,
            children: <Widget>[
              for (var item in stickers)
                TextButton(
                  onPressed: () {
                    isShowSticker = false;
                    sendMessage(item, 2);
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/stickers/' + item,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(10.0),
    );
  }
}
