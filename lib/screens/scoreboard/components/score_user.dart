import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/size_config.dart';

class ScoreUser extends StatefulWidget {
  final String name, image, score;
  final int index, userId;

  const ScoreUser({Key key, this.name, this.image, this.index, this.score, this.userId})
      : super(key: key);
  @override
  _ScoreUserState createState() => _ScoreUserState();
}

class _ScoreUserState extends State<ScoreUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.userId == sUserID ? Colors.blueAccent[200] : Colors.white,
      padding: EdgeInsets.only(left: getProportionateScreenWidth(10), right: getProportionateScreenWidth(16), top: getProportionateScreenHeight(10), bottom: getProportionateScreenHeight(10)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  child: widget.index == 0
                      ? Image.asset(
                          "assets/images/gold-cup.png",
                          width: getProportionateScreenWidth(30),
                        )
                      : widget.index == 1
                          ? Image.asset(
                              "assets/images/silver-cup.png",
                              width: getProportionateScreenWidth(30),
                            )
                          : widget.index == 2
                              ? Image.asset(
                                  "assets/images/bronze-cup.png",
                                  width: getProportionateScreenWidth(30),
                                )
                              : Center(
                                  child: Text(
                                      (widget.index + 1).toString() + ".")),
                  width: SizeConfig.screenWidth * 0.1,
                ),

                SizedBox(width: getProportionateScreenWidth(10)),
                CircleAvatar(
                  backgroundImage: widget.image.isEmpty
                      ? AssetImage("assets/images/Profile Image.png")
                      : NetworkImage(widget.image),
                  maxRadius: 30,
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
                        Text(widget.name,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        SizedBox(
                          height: 6,
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
                widget.score,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
