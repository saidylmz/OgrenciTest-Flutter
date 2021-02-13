import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otsappmobile/models/test_detail.dart';
import 'package:otsappmobile/models/user_test_info_model.dart';

class TestDetailController extends ControllerMVC {
  TestDetailController([StateMVC state]) : super(state);

  int testId;
  UserTestInfoModel testInfo;
  TestDetailModel testDetail;

  void setTestInfo(UserTestInfoModel model)=>setState(() => testInfo = model);
}
