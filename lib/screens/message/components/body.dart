import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/MessageController.dart';
import 'package:otsappmobile/services/firestore_service.dart';
import 'package:otsappmobile/size_config.dart';

import 'chat_user_list.dart';

class Body extends StatefulWidget {
  final MessageController controller;

  const Body({Key key, this.controller}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    //widget.controller.loadChats();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    onChanged: (value) {
                      widget.controller.searchText = value.toLowerCase();
                      widget.controller.searchList();
                    },
                    decoration: InputDecoration(
                      hintText: "Ara...",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      contentPadding:
                          EdgeInsets.only(left: 16, right: 16, top: 10),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade400,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: FirestoreService().getStreamUserChats(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              widget.controller.chatList =
                  (snapshot.data.documents as List<QueryDocumentSnapshot>)
                      .map((e) => FrChat.fromSnapshot2(e.id, e.data()))
                      .toList();
              widget.controller.chatList.sort(
                  (a, b) => b.lastMessageDate.compareTo(a.lastMessageDate));
              return ListView.builder(
                itemCount: widget.controller.chatList.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (c, i) {
                  var toId = widget.controller.chatList[i].members
                      .singleWhere((element) => element != sUserID);
                  // var toUser = sFrUsers?.singleWhere(
                  //     (element) => element.userId == toId,
                  //     orElse: () => null);
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where("userId", isEqualTo: toId)
                        .snapshots(),
                    builder: (c, s) {
                      if (s.hasData) {
                        var temp = (s.data.documents
                                as List<QueryDocumentSnapshot>).first;
                        var toUser = FrUser.fromSnapshot2(temp.id, temp.data());
                        return ChatUsersList(
                          chatId: widget.controller.chatList[i].documentId,
                          name: toUser?.name ?? "",
                          secondaryText:
                              widget.controller.chatList[i].lastMessage,
                          image: toUser?.photo ?? "",
                          time: readDateTime(
                              widget.controller.chatList[i].lastMessageDate),
                          isUserOnline: toUser?.online,
                        );
                      }
                      return Center(child: Image.asset("assets/images/spinner.gif"));
                    },
                  );
                },
              );
            } else
              return Center(child: Image.asset("assets/images/spinner.gif"));
          },
        )
      ],
    );
  }
}
