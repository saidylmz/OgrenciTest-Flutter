import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/MessageController.dart';
import 'package:otsappmobile/models/user_model.dart';
import 'package:otsappmobile/screens/message_detail/message_detail_screen.dart';
import 'package:otsappmobile/services/firestore_service.dart';
import 'package:otsappmobile/services/user_service.dart';
import 'components/body.dart';

List<dynamic> friendList = [];

class MessageScreen extends StatefulWidget {
  static String routeName = "/messages";

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends StateMVC<MessageScreen> {
  _MessageScreenState() : super(MessageController()) {
    _controller = controller;
  }
  MessageController _controller;

  @override
  void initState() {
    FirestoreService()
        .saveUserIsNotExist("Sercan", "https://i.stack.imgur.com/l60Hf.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mesajlarım"),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: showModal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kPrimaryColor),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Yeni",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Body(controller: _controller),
        bottomNavigationBar: BottomNavigatonBar(
          activeIndex: 3,
        ));
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Container(
                        height: 4,
                        width: 50,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                        future: UserService().getMessageUserList(),
                        builder: (ctx, snap) {
                          if (snap.hasData) {
                            var data = snap.data as List<UserModel>;
                            data.sort((a, b) => a.operationClaimId
                                .compareTo(b.operationClaimId));
                            var groupedData = groupBy(data,
                                (UserModel item) => item.operationClaimId);
                            return Column(
                              children: [
                                ListView.builder(
                                  itemCount: groupedData.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var data2 = List.from(groupedData.values);
                                    return Column(
                                      children: [
                                        Text(operationClaims[
                                            data2[index][0].operationClaimId]),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: data2[index].length,
                                          shrinkWrap: true,
                                          itemBuilder: (ctx, i) {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 0),
                                              child: ListTile(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  FirestoreService()
                                                      .saveUserIsNotExist(
                                                          data2[index]
                                                                      [i]
                                                                  .userName +
                                                              " " +
                                                              data2[index][i]
                                                                  .userSurName,
                                                          "https://i.stack.imgur.com/l60Hf.png",
                                                          userId: data2[index]
                                                                  [i]
                                                              .id);
                                                  var chat = _controller
                                                      .chatList
                                                      .where((element) =>
                                                          element.members.any(
                                                              (item) =>
                                                                  item ==
                                                                  data2[index]
                                                                          [i]
                                                                      .id));
                                                  if (chat.length == 0) {
                                                    FirestoreService()
                                                        .isChatDeleted(
                                                            data2[index][i].id)
                                                        .then((value) {
                                                        if (value == null)
                                                          Navigator.pushNamed(
                                                              context,
                                                              MessageDetailScreen
                                                                  .routeName,
                                                              arguments:
                                                                  data2[index][i]
                                                                      .id);
                                                        else
                                                          Navigator.pushNamed(
                                                              context,
                                                              MessageDetailScreen
                                                                  .routeName,
                                                              arguments: value);
                                                    });
                                                  } else
                                                    Navigator.pushNamed(
                                                        context,
                                                        MessageDetailScreen
                                                            .routeName,
                                                        arguments: chat
                                                            .first.documentId);
                                                },
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      "https://i.stack.imgur.com/l60Hf.png"),
                                                  maxRadius: 30,
                                                ),
                                                title: Text(
                                                  data2[index][i].userName +
                                                      " " +
                                                      data2[index][i]
                                                          .userSurName,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          } else
                            return Container();
                        })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
