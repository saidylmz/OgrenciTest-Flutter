class TestDetailScreenModel {
  TestDetailScreenModel(this.testId,
      {this.endDate, this.startDate, this.isCompleted});
  int testId;
  DateTime endDate, startDate;
  bool isCompleted;
}
