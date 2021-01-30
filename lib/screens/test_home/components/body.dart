import 'package:flutter/material.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/models/get_user_test_model.dart';
import 'package:otsappmobile/services/test_service.dart';
import 'course_content.dart';

GetUserTest model;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    model = GetUserTest(
        endDate: DateTime.now().add(Duration(days: 365)),
        startDate: DateTime.now().add(Duration(days: -365)),
        lessonId: -1,
        lessonSubjectId: -1,
        studentId: sUserID);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/ux_big.png"),
            alignment: Alignment.topRight,
            scale: 1.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Günlük Çözülen Soru"),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text("100"),
                    SizedBox(width: 10),
                    Icon(
                      Icons.dangerous,
                      color: Colors.red,
                    ),
                    Text("50"),
                  ],
                ),
                SizedBox(height: 20),
                Text("Toplam Çözülen Test"),
                SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text("100"),
                    SizedBox(width: 10),
                    Icon(
                      Icons.dangerous,
                      color: Colors.red,
                    ),
                    Text("50"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
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
                            future: TestService().getUserTests(model),
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
