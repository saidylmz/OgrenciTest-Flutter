import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:otsappmobile/models/test_answer.dart';
import 'package:otsappmobile/models/test_question_model.dart';
import 'package:otsappmobile/screens/test_question/components/progress_bar.dart';
import 'package:otsappmobile/screens/test_question/components/question_body.dart';
import 'package:otsappmobile/services/test_service.dart';
import 'package:otsappmobile/size_config.dart';

import '../../../constants.dart';

int currentQuestion = 1, totalCount = 0, testId = 0;
List<String> answers;
List<int> questionIds;
PageController pageController = PageController();
GlobalKey<_QuestionTopBarState> qTopBar = GlobalKey();
GlobalKey<_QuestionBottomBarState> qBottomBar = GlobalKey();

class Body extends StatefulWidget {
  const Body({Key key, @required this.testId, this.testQuestionCount})
      : super(key: key);
  final int testId;
  final int testQuestionCount;

  @override
  _BodyState createState() => _BodyState(testId);
}

class _BodyState extends State<Body> {
  _BodyState(int getTestId){
    testId = getTestId;
  }
  
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    currentQuestion = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(15)),
      child: Column(
        children: [
          QuestionTopBar(
            key: qTopBar,
            testQuestionCount: widget.testQuestionCount,
          ),
          FutureBuilder(
            future: TestService().getTestQuestions(testId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var testQs = snapshot.data as List<TestQuestionModel>;
                totalCount = testQs.length;
                answers = List.filled(totalCount, "");
                questionIds = List();
                testQs.forEach((element) {
                  questionIds.add(element.id);
                });
                return QuestionBody(
                  questions: snapshot.data,
                  pageController: pageController,
                  press: (val) {
                    answers[val.index] = val.value;
                  },
                  answers: answers,
                );
              } else
                return Center(child: Image.asset("assets/images/spinner.gif"));
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          QuestionBottomBar(
            qCount: widget.testQuestionCount,
          ),
        ],
      ),
    );
  }
}

class QuestionBottomBar extends StatefulWidget {
  const QuestionBottomBar({
    Key key,
    @required this.qCount,
  }) : super(key: key);

  final int qCount;

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
            pageController.previousPage(
                duration: Duration(milliseconds: 250), curve: Curves.ease);
            if (currentQuestion > 1)
              setState(() {
                currentQuestion--;
              });
            qTopBar.currentState.updateState(currentQuestion);
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
                  currentQuestion < widget.qCount ? 25 : 40)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: currentQuestion < widget.qCount ? kPrimaryColor : Colors.blue,
          onPressed: () {
            if (currentQuestion < widget.qCount) {
              pageController.nextPage(
                  duration: Duration(milliseconds: 250), curve: Curves.ease);
              if (currentQuestion < totalCount)
                setState(() {
                  currentQuestion++;
                });
              qTopBar.currentState.updateState(currentQuestion);
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
                  saveTestQuestions();
                },
              );
            }
          },
          child: Text(
            currentQuestion < widget.qCount ? "Sonraki Soru" : "Testi Bitir",
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

saveTestQuestions() {
  TestService().addTestAnswers(
    List<TestAnswerModel>.generate(
      totalCount,
      (index) => TestAnswerModel(
        answer: answers[index],
        createdAt: DateTime.now(),
        testQuestionId: questionIds[index],
        userId: sUserID,
      ),
    ),
  );
}

class QuestionTopBar extends StatefulWidget {
  const QuestionTopBar({
    this.testQuestionCount,
    Key key,
  }) : super(key: key);
  final int testQuestionCount;
  @override
  _QuestionTopBarState createState() => _QuestionTopBarState();
}

class _QuestionTopBarState extends State<QuestionTopBar> {
  int current = 1;

  updateState(int current) {
    setState(() {
      this.current = current;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ProgressBar(minute: 10, timeout: saveTestQuestions, testId: testId,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Soru " + current.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  "/" + widget.testQuestionCount.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Divider(thickness: 2),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}
