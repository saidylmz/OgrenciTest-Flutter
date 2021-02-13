import 'package:flutter/material.dart';

import '../../../models/test_home_model.dart';
import '../../../screens/test_detail/test_detail_screen.dart';
import '../../../size_config.dart';
import '../../../constants.dart';

class CourseContent extends StatelessWidget {
  final List<TestHomeModel> model;

  const CourseContent({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return model.length > 0
        ? Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: List.generate(
                model.length,
                (index) => Column(
                  children: [
                    SizedBox(height: 10),
                    FlatButton(
                      child: TestCard(index: index, test: model[index]),
                      onPressed: () => {
                        Navigator.pushNamed(
                          context,
                          TestDetailScreen.routeName,
                          arguments: model[index].testId,
                        )
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: Text(
              "Test bulunamadı.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          );
  }
}

class TestCard extends StatelessWidget {
  const TestCard({
    Key key,
    this.test,
    this.index,
  }) : super(key: key);

  final TestHomeModel test;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          (index + 1).toString().padLeft(2, "0"),
        ),
        SizedBox(width: 20),
        Container(
          width: getProportionateScreenWidth(220),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(test.testName,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                    )),
                Text(
                  test.lessonName + " / " + test.lessonSubjectName,
                  style: TextStyle(
                      color: kTextColor.withOpacity(.8),
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(left: 20),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: test.isActive ? Colors.green : kPrimaryColor,
          ),
          child: Icon(test.isActive ? Icons.check : Icons.play_arrow,
              color: Colors.white),
        ),
      ],
    );
  }
}
