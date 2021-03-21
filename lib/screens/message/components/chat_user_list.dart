import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/screens/message_detail/message_detail_screen.dart';
import 'package:otsappmobile/services/firestore_service.dart';
import 'package:otsappmobile/size_config.dart';

class ChatUsersList extends StatefulWidget {
  final String name, secondaryText, image, time, chatId;
  final bool isUserOnline;
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
        Navigator.pushNamed(context, MessageDetailScreen.routeName,
            arguments: widget.chatId);
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
                        backgroundColor:
                            widget.isUserOnline ? Colors.green : Colors.red,
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
                          Row(
                            children: [
                              Icon(
                                widget.secondaryText.startsWith("http")
                                    ? Icons.photo_camera
                                    : widget.secondaryText.endsWith("gif")
                                        ? Icons.tag_faces
                                        : Icons.textsms,
                              ),
                              SizedBox(width:getProportionateScreenWidth(5)),
                              Text(
                                widget.secondaryText.startsWith("http")
                                    ? "Fotoğraf"
                                    : widget.secondaryText.endsWith("gif")
                                        ? "Sticker"
                                        : widget.secondaryText.length > 30
                                            ? widget.secondaryText
                                                .substring(0, 30)
                                            : widget.secondaryText,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  widget.time,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                StreamBuilder(
                  stream:
                      FirestoreService().getUnreadMessageCount(widget.chatId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data =
                          snapshot.data.docs as List<QueryDocumentSnapshot>;
                      var count = data
                          .where((element) => element.data()["read"] == false)
                          .length;
                      if (count > 0)
                        return CircleAvatar(
                          backgroundColor: Colors.red,
                          maxRadius: 10,
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
