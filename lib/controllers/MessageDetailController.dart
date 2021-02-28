import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/services/firestore_service.dart';

class MessageDetailController extends ControllerMVC {

  MessageDetailController([StateMVC state]) : super(state);
  final ScrollController listScrollController = ScrollController();
  String chatId;
  FrChat chat;
  List<FrUser> toUser;

  loadChatInfo(String chatId) async{
    chatId = chatId;
    chat = await FirestoreService().getChat(chatId);
    chat.members = chat.members.where((element) => element != sUserID).toList();
    toUser = await FirestoreService().getUsers(chat.members);
    setState(() { });
  }
}
