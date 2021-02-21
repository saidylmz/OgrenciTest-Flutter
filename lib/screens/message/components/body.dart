import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/MessageController.dart';

import 'chat_user_list.dart';

class Body extends StatefulWidget {
  final MessageController controller;

  const Body({Key key, this.controller}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class ChatUsers {
  String text;
  String secondaryText;
  String image;
  String time;
  ChatUsers(
      {@required this.text,
      @required this.secondaryText,
      @required this.image,
      @required this.time});
}

String searchText ="";

List<ChatUsers> chatUsers = [
  ChatUsers(
      text: "Jane Russel",
      secondaryText: "Awesome Setup",
      image: "assets/images/Profile Image.png",
      time: "Now"),
  ChatUsers(
      text: "Glady's Murphy",
      secondaryText: "That's Great",
      image: "assets/images/Profile Image.png",
      time: "Yesterday"),
  ChatUsers(
      text: "Jorge Henry",
      secondaryText: "Hey where are you?",
      image: "assets/images/Profile Image.png",
      time: "31 Mar"),
  ChatUsers(
      text: "Philip Fox",
      secondaryText: "Busy! Call me in 20 mins",
      image: "assets/images/Profile Image.png",
      time: "28 Mar"),
  ChatUsers(
      text: "Debra Hawkins",
      secondaryText: "Thankyou, It's awesome",
      image: "assets/images/Profile Image.png",
      time: "23 Mar"),
  ChatUsers(
      text: "Jacob Pena",
      secondaryText: "will update you in evening",
      image: "assets/images/Profile Image.png",
      time: "17 Mar"),
  ChatUsers(
      text: "Andrey Jones",
      secondaryText: "Can you please share the file?",
      image: "assets/images/Profile Image.png",
      time: "24 Feb"),
  ChatUsers(
      text: "John Wick",
      secondaryText: "How are you?",
      image: "assets/images/Profile Image.png",
      time: "18 Feb"),
];

class _BodyState extends State<Body> {
  List<ChatUsers> list = chatUsers;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          searchText = value;
                          list = searchText.isNotEmpty ? chatUsers.where((x) => x.text.toLowerCase().contains(searchText.toLowerCase())).toList() : chatUsers;
                        });
                      },
                      decoration: InputDecoration(
                        
                        hintText: "Ara...",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              
              return ChatUsersList(
                text: list[index].text,
                secondaryText: list[index].secondaryText,
                image: list[index].image,
                time: list[index].time,
                isMessageRead: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
