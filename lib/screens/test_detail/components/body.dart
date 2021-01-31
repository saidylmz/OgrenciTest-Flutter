import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otsappmobile/components/default_button.dart';
import 'package:otsappmobile/models/test_detail.dart';
import 'package:otsappmobile/models/test_question_screen_model.dart';
import 'package:otsappmobile/screens/test_question/test_question_screen.dart';
import 'package:otsappmobile/size_config.dart';

import '../../../constants.dart';
import 'test_detail_title_desc.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.model}) : super(key: key);
  final TestDetailModel model;

  @override
  _BodyState createState() => _BodyState(model);
}

class _BodyState extends State<Body> {
  _BodyState(this.model);
  final TestDetailModel model;

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
                    desc: model.lessons
                        .firstWhere((x) => x.id == model.lessonId)
                        .name),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Konu",
                    desc: model.lessonSubjects
                        .firstWhere((x) => x.id == model.lessonSubjectId)
                        .name),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Soru Sayısı", desc: model.questionCount.toString()),
                if (model.description != null)
                  SizedBox(height: getProportionateScreenHeight(15)),
                if (model.description != null)
                  TestDetailTitleDesc(
                      title: "Açıklama", desc: model.description),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Başlangıç Tarihi",
                    desc:
                        DateFormat("dd.MM.yyyy HH:mm").format(model.startDate)),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Bitiş Tarihi",
                    desc: DateFormat("dd.MM.yyyy HH:mm").format(model.endDate)),
                SizedBox(height: getProportionateScreenHeight(15)),
                TestDetailTitleDesc(
                    title: "Oluşturan",
                    desc: model.createdUser.userName +
                        " " +
                        model.createdUser.userSurName),
                Text(model.createdUser.email),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: DefaultButton(
              text: "Testi Başlat",
              press: () => {
                Navigator.pushNamed(context, TestQuestionScreen.routeName,
                    arguments: TestQuestionScreenModel(model.id, model.name))
              },
            ),
          ),
        ),
      ],
    );
  }
}
