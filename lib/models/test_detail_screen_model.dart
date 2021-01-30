class TestDetailScreenModel {
  TestDetailScreenModel(this.endDate, this.startDate, this.testId,
      {this.isCompleted});
  int testId;
  DateTime startDate;
  DateTime endDate;
  bool isCompleted;
}
