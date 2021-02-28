import 'package:flutter/material.dart';
import 'package:otsappmobile/screens/message_detail/message_detail_screen.dart';

class ChatUsersList extends StatefulWidget {
  String name, secondaryText, image, time, chatId;
  bool isUserOnline;
  ChatUsersList(
      {@required this.name,
      @required this.secondaryText,
      @required this.image,
      @required this.time,
      @required this.chatId,
      @required this.isUserOnline});
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return ChatDetailPage();
        // }));
        Navigator.pushNamed(context, MessageDetailScreen.routeName, arguments: widget.chatId);
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.image),
                    maxRadius: 30,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: widget.isUserOnline ? Colors.green : Colors.red,
                        maxRadius: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.secondaryText,
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
