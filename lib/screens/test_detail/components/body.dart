import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otsappmobile/controllers/TestDetailController.dart';

import '../../../components/default_button.dart';
import '../../../models/test_question_screen_model.dart';
import '../../../screens/test_question/test_question_screen.dart';
import '../../../size_config.dart';
import '../../../constants.dart';
import 'test_detail_title_desc.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.controller}) : super(key: key);
  final TestDetailController controller;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: sUser.gender == true
                  ? AssetImage("assets/images/test_detail_man.png")
                  : AssetImage("assets/images/test_detail_woman.png"),
              alignment: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TestDetailTitleDesc(
                    title: "Ders",
                    desc: widget.controller.testDetail.lessons
                        .firstWhere((x) =>
                            x.id == widget.controller.testDetail.lessonId)
                        .name),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Konu",
                    desc: widget.controller.testDetail.lessonSubjects
                        .firstWhere((x) =>
                            x.id ==
                            widget.controller.testDetail.lessonSubjectId)
                        .name),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Soru Sayısı",
                    desc:
                        widget.controller.testDetail.questionCount.toString()),
                if (widget.controller.testDetail.description != null)
                  SizedBox(height: getProportionateScreenHeight(15)),
                if (widget.controller.testDetail.description != null)
                  TestDetailTitleDesc(
                      title: "Açıklama",
                      desc: widget.controller.testDetail.description),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Başlangıç Tarihi",
                    desc: widget.controller.testInfo == null ? "-" : DateFormat("dd.MM.yyyy HH:mm")
                        .format(widget.controller.testInfo.startDate)),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Bitiş Tarihi",
                    desc: widget.controller.testInfo == null ? "-" : DateFormat("dd.MM.yyyy HH:mm")
                        .format(widget.controller.testInfo.endDate)),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Oluşturan",
                    desc: widget.controller.testDetail.createdUser.userName +
                        " " +
                        widget.controller.testDetail.createdUser.userSurName),
                Text(widget.controller.testDetail.createdUser.email),
              ],
            ),
          ),
        ),
        if (!widget.controller.testInfo.isCompleted && widget.controller.testInfo.endDate.isBefore(DateTime.now()))
          Container(child: Text("Teste katılım süreniz bitmiştir.", style: TextStyle(fontSize: 18),)),
        //if (!widget.controller.testInfo.isCompleted && widget.controller.testInfo.endDate.isAfter(DateTime.now()))
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: DefaultButton(
                text: "Testi Başlat",
                press: () => {
                  Navigator.popAndPushNamed(
                      context, TestQuestionScreen.routeName,
                      arguments: TestQuestionScreenModel(
                          widget.controller.testDetail.id,
                          widget.controller.testDetail.questionCount,
                          widget.controller.testDetail.name))
                },
              ),
            ),
          ),
        if (widget.controller.testInfo.isCompleted)
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: DefaultButton(
                text: "Cevaplara Gözat",
                press: () => {
                  //TODO:test cevap detay
                },
              ),
            ),
          ),
      ],
    );
  }
}
