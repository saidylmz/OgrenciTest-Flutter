import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/MessageDetailController.dart';
import 'package:otsappmobile/services/firestore_service.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  final MessageDetailController controller;

  const Body({Key key, this.controller}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(widget.controller.chatId)
                  .collection(widget.controller.chatId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)));
                } else {
                  return ListView.builder(
                     padding: EdgeInsets.only(top: 10,bottom: 10),
                     shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var temp2 = (snapshot.data.documents as List<QueryDocumentSnapshot>)[index];
                      return ChatBubble(message: FrMessage.fromSnapshot2(temp2.id, temp2.data()));
                    },
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: widget.controller.listScrollController,
                  );
                }
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
      );
  }
}


class ChatBubble extends StatefulWidget{
  FrMessage message;
  ChatBubble({@required this.message});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
      child: Align(
        alignment: (widget.message.sender == sUserID ? Alignment.topRight : Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: (widget.message.sender == sUserID ? Colors.grey.shade200: kPrimaryColor),
          ),
          padding: EdgeInsets.all(16),
          child: Text(widget.message.message, style: TextStyle(color: (widget.message.sender == sUserID ?  Colors.black : Colors.white)),),
        ),
      ),
    );
  }
}