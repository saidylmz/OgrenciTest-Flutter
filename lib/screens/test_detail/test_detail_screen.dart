import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/controllers/TestDetailController.dart';
import '../../models/test_detail.dart';
import '../../services/test_service.dart';

import 'components/body.dart';

class TestDetailScreen extends StatefulWidget {
  static String routeName = "/testdetail";
  @override
  _TestDetailScreenState createState() => _TestDetailScreenState();
}

String title = "Test Detay";

class _TestDetailScreenState extends StateMVC<TestDetailScreen> {
  _TestDetailScreenState() : super(TestDetailController()) {
    _controller = controller;
  }
  TestDetailController _controller;
  @override
  Widget build(BuildContext context) {
    _controller.testId = ModalRoute.of(context).settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: TestService().getUserTestInfo(_controller.testId),
        builder: (context2, snapshot2) {
          if (snapshot2.hasData) {
            _controller.testInfo = snapshot2.data;
            return FutureBuilder(
              future: TestService().getTestDetail(_controller.testId),
              builder: (context, snapshot) {
                if (snapshot.hasData && _controller.testInfo != null) {
                  _controller.testDetail = snapshot.data as TestDetailModel;
                  title = _controller.testDetail.name;
                  return Body(controller: _controller);
                } else
                  return Center(
                      child: Image.asset("assets/images/spinner.gif"));
              },
            );
          } else
            return Center(child: Image.asset("assets/images/spinner.gif"));
        },
      ),
    );
  }
}
