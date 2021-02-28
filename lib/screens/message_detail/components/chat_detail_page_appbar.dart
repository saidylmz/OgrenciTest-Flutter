import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/MessageDetailController.dart';
import 'package:otsappmobile/services/firestore_service.dart';

class ChatDetailPageAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final MessageDetailController controller;

  const ChatDetailPageAppBar({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              if (controller.toUser != null && controller.toUser.length == 1)
                CircleAvatar(
                  backgroundImage: NetworkImage(controller.toUser.first.photo),
                  maxRadius: 20,
                ),
              SizedBox(
                width: 12,
              ),
              if (controller.toUser != null && controller.toUser.length == 1)
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(controller.toUser.first.documentId)
                      .snapshots(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      var temp = (snap.data as DocumentSnapshot);
                      controller.toUser[0] =
                          FrUser.fromSnapshot2(temp.id, temp.data());
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              controller.toUser.first.name,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              controller.toUser.first.online
                                  ? "Çevrimiçi"
                                  : "Çevrimdışı",
                              style: TextStyle(
                                  color: controller.toUser.first.online
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    } else
                      return Text("");
                  },
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
