import 'package:flutter/material.dart';
import 'package:otsappmobile/models/test_detail.dart';
import 'package:otsappmobile/models/test_detail_screen_model.dart';
import 'package:otsappmobile/services/test_service.dart';

import 'components/body.dart';

class TestDetailScreen extends StatefulWidget {
  static String routeName = "/testdetail";
  @override
  _TestDetailScreenState createState() => _TestDetailScreenState();
}

String title = "Test Detay";

class _TestDetailScreenState extends State<TestDetailScreen> {

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context).settings.arguments as TestDetailScreenModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: TestService()
            .getTestDetail(model.testId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var getData = (snapshot.data as TestDetailModel);
            getData.startDate = model.startDate;
            getData.endDate = model.endDate;
            if(model.isCompleted != null) getData.isComplete = model.isCompleted;
            title = getData.name;
            return Body(model: getData);
          } else
            return Center(child: Image.asset("assets/images/spinner.gif"));
        },
      ),
    );
  }
}
