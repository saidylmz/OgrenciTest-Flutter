import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/TestHomeController.dart';
import '../../../services/test_service.dart';
import 'course_content.dart';

TestHomeController _controller;

class Body extends StatefulWidget {
  final TestHomeController controller;

  const Body({Key key, this.controller}) : super(key: key);
  @override
  _BodyState createState() {
    _controller = controller;
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/ux_big.png"),
            alignment: Alignment.topRight,
            scale: 1.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (_controller.testAnswerStatistic != null)
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Günlük Çözülen Soru"),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text(_controller.testAnswerStatistic.dayCorrect
                          .toString()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.dangerous,
                        color: Colors.red,
                      ),
                      Text(_controller.testAnswerStatistic.dayWrong.toString()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.help_outlined,
                        color: Colors.blue,
                      ),
                      Text(_controller.testAnswerStatistic.dayEmpty.toString()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Haftalık Çözülen Soru"),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text(_controller.testAnswerStatistic.weekCorrect
                          .toString()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.dangerous,
                        color: Colors.red,
                      ),
                      Text(
                          _controller.testAnswerStatistic.weekWrong.toString()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.help_outlined,
                        color: Colors.blue,
                      ),
                      Text(
                          _controller.testAnswerStatistic.weekEmpty.toString()),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Toplam Çözülen Test"),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      Text(_controller.testAnswerStatistic.totalCorrect
                          .toString()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.dangerous,
                        color: Colors.red,
                      ),
                      Text(_controller.testAnswerStatistic.totalWrong
                          .toString()),
                      SizedBox(width: 10),
                      Icon(
                        Icons.help_outlined,
                        color: Colors.blue,
                      ),
                      Text(_controller.testAnswerStatistic.totalEmpty
                          .toString()),
                    ],
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.only(left: 35, top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, -1),
                  spreadRadius: 5,
                  blurRadius: 7,
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Text(
              "TESTLER",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black),
            ),
            width: double.infinity,
            height: 60,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future: TestService().getUserTests(sUserID),
                            builder: (context, snapshot) => snapshot.hasData
                                ? CourseContent(model: snapshot.data)
                                : Center(
                                    child: Image.asset(
                                        "assets/images/spinner.gif")),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
