import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otsappmobile/controllers/MessageDetailController.dart';
import 'package:otsappmobile/services/firestore_service.dart';
import 'package:otsappmobile/size_config.dart';

import '../../../constants.dart';
import 'full_photo.dart';

class Body extends StatefulWidget {
  final MessageDetailController controller;

  const Body({Key key, this.controller}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.chatId != null
        ? Stack(
            children: <Widget>[
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .doc(widget.controller.chatId)
                    .collection(widget.controller.chatId)
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor)));
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.only(
                          top: getProportionateScreenHeight(10),
                          bottom: getProportionateScreenHeight(60)),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var temp2 = (snapshot.data.documents
                            as List<QueryDocumentSnapshot>)[index];
                        return ChatBubble(
                            message: FrMessage.fromSnapshot2(
                                temp2.id, temp2.data()));
                      },
                      itemCount: snapshot.data.documents.length,
                      reverse: true,
                      controller: widget.controller.listScrollController,
                    );
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, bottom: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModal();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextField(
                            controller: widget.controller.inputController,
                            onChanged: (value) =>
                                widget.controller.inputText = value,
                            decoration: InputDecoration(
                                hintText: "Mesajınızı yazınız...",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.all(16)),
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
                  padding: EdgeInsets.only(right: 15, bottom: 7),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (widget.controller.inputText.isNotEmpty) {
                        widget.controller
                            .sendMessage(widget.controller.inputText, 0);
                        widget.controller.inputController.text = "";
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: kPrimaryColor,
                    elevation: 1,
                  ),
                ),
              )
            ],
          )
        : Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 16, bottom: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showModal();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 21,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: TextField(
                            controller: widget.controller.inputController,
                            onChanged: (value) =>
                                widget.controller.inputText = value,
                            decoration: InputDecoration(
                                hintText: "Mesajınızı yazınız...",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade500),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.all(16)),
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
                  padding: EdgeInsets.only(right: 15, bottom: 7),
                  child: FloatingActionButton(
                    onPressed: () {
                      if (widget.controller.inputText.isNotEmpty) {
                        widget.controller
                            .sendMessageFirst(widget.controller.inputText, 0);
                        widget.controller.inputController.text = "";
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                    backgroundColor: kPrimaryColor,
                    elevation: 1,
                  ),
                ),
              )
            ],
          );
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: SizeConfig.screenHeight / 3,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
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
                  widget.controller.isShowSticker
                      ? WillPopScope(
                          child: widget.controller.buildSticker(context),
                          onWillPop: () {
                            if (widget.controller.isShowSticker) {
                              widget.controller.isShowSticker = false;
                              Navigator.pop(context);
                              showModal();
                            } else {
                              Navigator.pop(context);
                            }
                            return Future.value(false);
                          },
                        )
                      : ListView.builder(
                          itemCount: widget.controller.menuItems.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(top: 10, bottom: 0),
                              child: ListTile(
                                onTap: () {
                                  switch (
                                      widget.controller.menuItems[index].type) {
                                    case 0:
                                      Navigator.pop(context);
                                      widget.controller.getImage(false);
                                      break;
                                    case 1:
                                      Navigator.pop(context);
                                      widget.controller.getImage(true);
                                      break;
                                    case 2:
                                      widget.controller.isShowSticker = true;
                                      Navigator.pop(context);
                                      showModal();
                                      break;
                                  }
                                },
                                leading: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: widget.controller.menuItems[index]
                                        .color.shade50,
                                  ),
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    widget.controller.menuItems[index].icons,
                                    size: 30,
                                    color: widget.controller.menuItems[index]
                                        .color.shade400,
                                  ),
                                ),
                                title: Text(
                                  widget.controller.menuItems[index].text,
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          );
        });
  }
}

class ChatBubble extends StatefulWidget {
  FrMessage message;
  ChatBubble({@required this.message});
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(16),
          right: getProportionateScreenWidth(16),
          top: getProportionateScreenHeight(5),
          bottom: getProportionateScreenHeight(5)),
      child: Align(
        alignment: (widget.message.sender == sUserID
            ? Alignment.topRight
            : Alignment.topLeft),
        child: Container(
          width: SizeConfig.screenWidth / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20)),
            color: widget.message.type == 2
                ? Colors.transparent
                : (widget.message.sender == sUserID
                    ? Colors.grey.shade200
                    : kPrimaryColor),
          ),
          padding: EdgeInsets.fromLTRB(
              getProportionateScreenWidth(16),
              widget.message.type == 1
                  ? getProportionateScreenWidth(16)
                  : getProportionateScreenWidth(5),
              getProportionateScreenWidth(16),
              getProportionateScreenWidth(5)),
          child: Column(
            crossAxisAlignment: widget.message.sender == sUserID
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              widget.message.type == 0
                  ? Text(
                      widget.message.message,
                      style: TextStyle(
                          color: (widget.message.sender == sUserID
                              ? Colors.black
                              : Colors.white)),
                    )
                  : widget.message.type == 1
                      ? Container(
                          child: FlatButton(
                            child: Material(
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        kPrimaryColor),
                                  ),
                                  width: getProportionateScreenWidth(150),
                                  height: getProportionateScreenHeight(150),
                                  padding: EdgeInsets.all(70.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Material(
                                  child: Image.asset(
                                    'images/img_not_available.jpeg',
                                    width: getProportionateScreenWidth(150),
                                    height: getProportionateScreenHeight(150),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                                imageUrl: widget.message.message,
                                width: getProportionateScreenWidth(150),
                                height: getProportionateScreenHeight(150),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullPhoto(
                                          url: widget.message.message)));
                            },
                            padding: EdgeInsets.all(0),
                          ),
                        )
                      : Image.asset(
                          'assets/stickers/' + widget.message.message,
                          width: getProportionateScreenWidth(100),
                          height: getProportionateScreenHeight(100),
                          fit: BoxFit.cover,
                        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    readDateTime(widget.message.date),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 12,
                        color: (widget.message.sender == sUserID
                            ? Colors.black
                            : Colors.black)),
                  ),
                  SizedBox(width: getProportionateScreenWidth(5)),
                  widget.message.read
                      ? SvgPicture.asset(
                          "assets/icons/Double Tick.svg",
                          color: Colors.blue,
                          height: getProportionateScreenHeight(16),
                        )
                      : Icon(
                          Icons.check,
                          size: getProportionateScreenHeight(16),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
