import 'package:flutter/material.dart';
import 'package:otsappmobile/controllers/ScoreBoardController.dart';
import 'package:otsappmobile/models/scoreboard_model.dart';
import 'package:otsappmobile/screens/scoreboard/components/score_user.dart';
import 'package:otsappmobile/services/user_service.dart';

class Body extends StatelessWidget {
  const Body({Key key, this.controller}) : super(key: key);
  final ScoreBoardController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService().getScoreBoardStatistic(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          controller.scoreBoardData = snapshot.data as ScoreBoardModel;
          return TabBarView(
              controller: controller.tabController,
              children: <Widget>[TabFirst(controller: controller), TabSecond(controller: controller), TabThird(controller: controller)]);
        } else
          return Center(child: Image.asset("assets/images/spinner.gif"));
      },
    );
  }
}

class TabFirst extends StatelessWidget {
  const TabFirst({
    Key key, this.controller,
  }) : super(key: key);
  final ScoreBoardController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.scoreBoardData.victories.length,
      itemBuilder: (ctx, index) {
        return ScoreUser(
            name: controller.scoreBoardData.victories[index].userNameSurname,
            index: index,
            score: "%" + controller.scoreBoardData.victories[index].value.toString(),
            image: controller.scoreBoardData.victories[index].image,
            userId: controller.scoreBoardData.victories[index].userId);
      },
    );
  }
}

class TabSecond extends StatelessWidget {
  const TabSecond({
    Key key, this.controller,
  }) : super(key: key);
  final ScoreBoardController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.scoreBoardData.victories.length,
      itemBuilder: (ctx, index) {
        return ScoreUser(
            name: controller.scoreBoardData.questionCounts[index].userNameSurname,
            index: index,
            score: controller.scoreBoardData.questionCounts[index].value.toString(),
            image: controller.scoreBoardData.questionCounts[index].image,
            userId: controller.scoreBoardData.questionCounts[index].userId);
      },
    );
  }
}

class TabThird extends StatelessWidget {
  const TabThird({
    Key key, this.controller,
  }) : super(key: key);
final ScoreBoardController controller;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.scoreBoardData.victories.length,
      itemBuilder: (ctx, index) {
        return ScoreUser(
            name: controller.scoreBoardData.classRooms[index].userNameSurname,
            index: index,
            score: controller.scoreBoardData.classRooms[index].value.toString(),
            image: controller.scoreBoardData.classRooms[index].image,
            userId: controller.scoreBoardData.classRooms[index].userId);
      },
    );
  }
}
