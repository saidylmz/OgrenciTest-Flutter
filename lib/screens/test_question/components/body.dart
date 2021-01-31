import 'package:flutter/material.dart';
import 'package:otsappmobile/components/default_button.dart';
import 'package:otsappmobile/models/test_question_model.dart';
import 'package:otsappmobile/screens/test_question/components/progress_bar.dart';
import 'package:otsappmobile/screens/test_question/components/question_card.dart';
import 'package:otsappmobile/services/test_service.dart';
import 'package:otsappmobile/size_config.dart';

import '../../../constants.dart';

int currentQuestion = 1;
List<int> answers = List.filled(0, 0);

class Body extends StatefulWidget {
  const Body({Key key, @required this.testId}) : super(key: key);
  final int testId;

  @override
  _BodyState createState() => _BodyState(testId);
}

class _BodyState extends State<Body> {
  _BodyState(this.testId);
  final int testId;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentQuestion = 1;
    return SingleChildScrollView(
      child: FutureBuilder(
        future: TestService().getTestQuestions(testId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var model = (snapshot.data as List<TestQuestionModel>);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ProgressBar(minute: 120),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Soru " + currentQuestion.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              "/" + model.length.toString(),
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
                      QuestionCard(question: model[0]),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                              color: Colors.grey,
                              onPressed: (){},
                              child: Text(
                                "Önceki Soru",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
                              color: kPrimaryColor,
                              onPressed: (){},
                              child: Text(
                                "Sonraki Soru",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(18),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                    ],
                  ),
                ),
              ],
            );
          } else
            return Center(child: Image.asset("assets/images/spinner.gif"));
        },
      ),
    );
  }
}
