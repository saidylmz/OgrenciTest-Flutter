import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/controllers/MessageDetailController.dart';

import 'components/body.dart';
import 'components/chat_detail_page_appbar.dart';

class MessageDetailScreen extends StatefulWidget {
  static String routeName = "/messagedetail";

  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}

enum MessageType {
  Sender,
  Receiver,
}

class _MessageDetailScreenState extends StateMVC<MessageDetailScreen> {
  _MessageDetailScreenState() : super(MessageDetailController()) {
    _controller = controller;
  }
  MessageDetailController _controller;

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context).settings.arguments;
    if (arg is String) {
      String chatId = arg;
      _controller.chatId = chatId;
      _controller.loadChatInfo(chatId);
    }else{
      _controller.loadNewChat(arg);
    }
    return Scaffold(
      appBar: ChatDetailPageAppBar(controller: _controller),
      body: Body(controller: _controller),
    );
  }
}
