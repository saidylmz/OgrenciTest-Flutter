import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';

import 'components/chat_detail_page_appbar.dart';

class MessageDetailScreen extends StatefulWidget {
  static String routeName = "/messagedetail";
  @override
  _MessageDetailScreenState createState() => _MessageDetailScreenState();
}
enum MessageType{
  Sender,
  Receiver,
}

class ChatMessage{
  String message;
  MessageType type;
  ChatMessage({@required this.message,@required this.type});
}
 List<ChatMessage> chatMessage = [
    ChatMessage(message: "Hi John", type: MessageType.Receiver),
    ChatMessage(message: "Hope you are doin good", type: MessageType.Receiver),
    ChatMessage(message: "Hello Jane, I'm good what about you", type: MessageType.Sender),
    ChatMessage(message: "I'm fine, Working from home", type: MessageType.Receiver),
    ChatMessage(message: "Oh! Nice. Same here man", type: MessageType.Sender),
  ];

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: chatMessage.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
            return ChatBubble(
              chatMessage: chatMessage[index],
            );
            },
         ),
          Padding(
            padding: EdgeInsets.only(right:10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 16,bottom: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        //showModal();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.camera_alt,color: Colors.white,size: 21,),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Mesajınızı yazınız...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.all(16)
                        ),
                      ),
                      
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 50,
              padding: EdgeInsets.only(right: 15,bottom: 7),
              child: FloatingActionButton(
                onPressed: (){},
                child: Icon(Icons.send,color: Colors.white, size: 20,),
                backgroundColor: kPrimaryColor,
                elevation: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}


class ChatBubble extends StatefulWidget{
  ChatMessage chatMessage;
  ChatBubble({@required this.chatMessage});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (widget.chatMessage.type == MessageType.Receiver?Alignment.topLeft:Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.chatMessage.type  == MessageType.Receiver ? kPrimaryColor : Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text(widget.chatMessage.message, style: TextStyle(color: (widget.chatMessage.type  == MessageType.Receiver ? Colors.white : Colors.black)),),
        ),
      ),
    );
  }
}