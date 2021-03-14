import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/components/bottom_navigation_bar.dart';
import 'package:otsappmobile/constants.dart';
import 'package:otsappmobile/controllers/ScoreBoardController.dart';
import 'package:otsappmobile/size_config.dart';

import 'components/body.dart';

class ScoreBoardScreen extends StatefulWidget {
  static String routeName = "/scoreboard";
  @override
  _ScoreBoardScreenState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends StateMVC<ScoreBoardScreen>
    with SingleTickerProviderStateMixin {
  _ScoreBoardScreenState() : super(ScoreBoardController()) {
    _controller = controller;
  }
  ScoreBoardController _controller;
  @override
  void initState() {
    super.initState();
    _controller.tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("İstatistik",style: TextStyle(color: Colors.white),),
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            bottom: new TabBar(
                controller: _controller.tabController,
                tabs: <Tab>[
                  new Tab(icon: Image.asset("assets/images/award.png", width: getProportionateScreenWidth(30),),text: "Başarı", iconMargin: EdgeInsets.all(1),),
                  new Tab(icon: Image.asset("assets/images/scoring.png", width: getProportionateScreenWidth(30),), text: "Soru Sayısı",),
                  new Tab(icon: Image.asset("assets/images/presentation.png", width: getProportionateScreenWidth(30),), text: "Sınıfındakiler",)
                ])),
        bottomNavigationBar: BottomNavigatonBar(
          activeIndex: 1,
        ),
        body: Body(controller: _controller));
  }
}
