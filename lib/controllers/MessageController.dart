import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/services/firestore_service.dart';

import '../constants.dart';

class MessageController extends ControllerMVC {
  MessageController([StateMVC state]) : super(state);

  String searchText = "";
  List<FrChat> _chats;
  List<FrChat> chatList;
  
  searchList() {
    var find = sFrUsers
        .where((element) => element.name.toLowerCase().contains(searchText))
        .map((e) => e.userId)
        .toList();
    chatList = searchText.isEmpty || searchText.length < 2
        ? _chats
        : _chats
            .where((x) => x.members.any((element) => find.contains(element)))
            .toList();
    setState(() {});
  }

  deleteChat(int index) {
    chatList[index].deletedMembers.add(sUserID);
    var frInstance = FirebaseFirestore.instance;
    frInstance
        .collection("chats")
        .doc(chatList[index].documentId)
        .update({"deletedMembers": chatList[index].deletedMembers});
    if (chatList[index].deletedMembers.length ==
        chatList[index].members.length) {
      frInstance
          . collection("messages")
          .doc(chatList[index].documentId)
          .collection(chatList[index].documentId)
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));
      frInstance
          .collection("messages")
          .doc(chatList[index].documentId)
          .delete();
      //frInstance.collection("chats").doc(chatList[index].documentId).delete();
    }
  }
}
