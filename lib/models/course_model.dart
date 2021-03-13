import 'package:elgam3a_admin/services/vars.dart';

class CourseModel {
  CourseModel({
    this.courseID,
    this.courseName,
    this.courseCode,
    this.courseDoctor,
    this.courseAssistants,
    this.courseLocation,
    this.courseDay,
    this.courseTime,
    this.courseHall,
    this.courseHours,
    this.courseDepartment,
    this.isRequired,
    this.show,
  });

  String courseID;
  String courseName;
  int courseHours;
  String courseCode;
  String courseDoctor;
  List<String> courseAssistants;
  String courseLocation;
  String courseDay;
  String courseTime;
  String courseDepartment;
  int courseHall;
  bool isRequired;
  bool show;

  CourseModel.fromMap(Map<String, dynamic> m) {
    courseName = m[CourseData.NAME];
    courseCode = m[CourseData.CODE];
    courseDoctor = m[CourseData.DOCTOR];
    courseHours = m[CourseData.CREDIT_HOURS];
    courseID = m[CourseData.ID];
    show = m[CourseData.SHOW];
//    m[CourseData.ASSISTANTS]?.forEach(
//          (e) => courseAssistants.add(
//        UserModel.fromMap(e),
//      ),
//    );
//    courseAssistants = m[CourseData.ASSISTANTS];
    courseLocation = m[CourseData.LOCATION];
    courseDay = m[CourseData.DAY];
    courseTime = m[CourseData.TIMES];
    courseHall = m[CourseData.HALL];
    courseDepartment = m[CourseData.DEPARTMENT];
    isRequired = m[CourseData.REQUIRED];
  }

  Map<String, dynamic> toMap() {
    return {
      CourseData.NAME: courseName,
      CourseData.CODE: courseCode,
      CourseData.DOCTOR: courseDoctor,
      CourseData.CREDIT_HOURS: courseHours,
      CourseData.ASSISTANTS: courseAssistants ?? [],
      CourseData.LOCATION: courseLocation,
      CourseData.DAY: courseDay,
      CourseData.TIMES: courseTime,
      CourseData.HALL: courseHall,
      CourseData.DEPARTMENT: courseDepartment,
      CourseData.REQUIRED: isRequired,
      CourseData.SHOW: show ?? false,
    };
  }

  CourseModel copyWith({
    String courseID,
    String courseName,
    int courseHours,
    String courseCode,
    String courseDoctor,
    List<String> courseAssistants,
    String courseLocation,
    String courseDay,
    String courseTime,
    String courseDepartment,
    int courseHall,
    bool isRequired,
    bool show,
  }) {
    return CourseModel(
      courseID: this.courseID,
      courseName: courseName ?? this.courseName,
      courseCode: courseCode ?? this.courseCode,
      courseDoctor: courseDoctor ?? this.courseDoctor,
      courseHours: courseHours ?? this.courseHours,
      courseAssistants: courseAssistants ?? this.courseAssistants,
      courseLocation: courseLocation ?? this.courseLocation,
      courseDay: courseDay ?? this.courseDay,
      courseTime: courseTime ?? this.courseTime,
      courseHall: courseHall ?? this.courseHall,
      courseDepartment: courseDepartment ?? this.courseDepartment,
      isRequired: isRequired ?? this.isRequired,
      show: show ?? this.show,
    );
  }

  @override
  String toString() {
    return courseName;
  }
}
