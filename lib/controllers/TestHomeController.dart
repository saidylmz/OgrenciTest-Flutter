import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/models/test_answers_statistic_model.dart';
import 'package:otsappmobile/services/test_service.dart';

class TestHomeController extends ControllerMVC {
  TestHomeController([StateMVC state]) : super(state) {
    TestService()
        .getTestAnswerStatistic()
        .then((value) => setState(() => testAnswerStatistic = value));
  }

  TestAnswerStatisticModel testAnswerStatistic;
}
