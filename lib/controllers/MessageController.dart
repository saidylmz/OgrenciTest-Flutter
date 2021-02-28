import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/services/firestore_service.dart';

import '../constants.dart';

class MessageController extends ControllerMVC {
  MessageController([StateMVC state]) : super(state);

  String searchText = "";
  List<FrChat> _chats;
  List<FrChat> chatList;

  // loadChats() async {
  //   //_chats = await FirestoreService().getUserChats();
  //   //FirestoreService().getUserChats((value) => _chatListener(value));
  //   searchList();
  // }

  searchList() {
    var find = sFrUsers
        .where((element) => element.name.toLowerCase().contains(searchText))
        .map((e) => e.userId)
        .toList();
      chatList = searchText.isEmpty || searchText.length < 2
          ? _chats
          : _chats
              .where((x) => x.members.any((element) => find.contains(element))).toList();
    setState(() {});
  }
}
