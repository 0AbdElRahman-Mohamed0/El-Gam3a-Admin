class CourseModel {
  CourseModel({
    this.courseName,
    this.courseCode,
    this.courseDoctor,
    this.courseAssistants,
    this.courseLocation,
    this.courseDay,
    this.courseTime,
    this.courseHall,
    this.courseHours,
    this.required,
  });

  String courseName;
  int courseHours;
  String courseCode;
  String courseDoctor;
  List<String> courseAssistants;
  String courseLocation;
  String courseDay;
  String courseTime;
  int courseHall;
  bool required;
}
