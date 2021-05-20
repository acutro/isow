class TaskModel {
  int courseId;
  String courseName;
  String courseDetails;
  int duration;
  double fee;

  TaskModel(
      {this.courseId,
      this.courseName,
      this.courseDetails,
      this.duration,
      this.fee});

  TaskModel.fromJson(Map<String, dynamic> json) {
    courseId = json['CourseId'] ?? "";
    courseName = json['CourseName'] ?? "";
    courseDetails = json['CourseDetails'] ?? "";
    duration = json['Duration'] ?? "";
    fee = json['Fees'] ?? "";
  }
}
