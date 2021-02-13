import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/TestQuestionController.dart';
import 'package:otsappmobile/screens/test_detail/test_detail_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class QuestionBottomBar extends StatefulWidget {
  const QuestionBottomBar({
    Key key, this.controller,
  }) : super(key: key);

  final TestQuestionController controller;

  @override
  _QuestionBottomBarState createState() => _QuestionBottomBarState();
}

class _QuestionBottomBarState extends State<QuestionBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.grey,
          onPressed: () {
            widget.controller.pageController.previousPage(
                duration: Duration(milliseconds: 250), curve: Curves.ease);
            if (widget.controller.currentQuestion > 1)
              widget.controller.updateCurrentQuestion(-1);
          },
          child: Text(
            "Önceki Soru",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
            ),
          ),
        ),
        FlatButton(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(
                  widget.controller.currentQuestion < widget.controller.testQuestionCount ? 25 : 40)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: widget.controller.currentQuestion < widget.controller.testQuestionCount ? kPrimaryColor : Colors.blue,
          onPressed: () {
            if (widget.controller.currentQuestion < widget.controller.testQuestionCount) {
              widget.controller.pageController.nextPage(
                  duration: Duration(milliseconds: 250), curve: Curves.ease);
              if (widget.controller.currentQuestion < widget.controller.testQuestionCount)
                widget.controller.updateCurrentQuestion(1);
            } else {
              confirmationDialog(
                context,
                "Testi bitirdiğiniz takdirde cevaplarınız kaydedilir ve değiştirilemez.",
                title: "Testi Bitir",
                confirm: false,
                positiveText: "Bitir",
                neutralText: "İptal",
                closeOnBackPress: true,
                positiveAction: () {
                  widget.controller.saveTestQuestions();
                  Navigator.popAndPushNamed(context, TestDetailScreen.routeName, arguments: widget.controller.testId);
                },
              );
            }
          },
          child: Text(
            widget.controller.currentQuestion < widget.controller.testQuestionCount ? "Sonraki Soru" : "Testi Bitir",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
