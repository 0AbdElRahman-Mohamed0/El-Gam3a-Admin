import 'package:elgam3a_admin/services/vars.dart';

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
    this.courseDepartment,
    this.required,
  });

  String courseID;
  String courseName;
  String courseHours;
  String courseCode;
  String courseDoctor;
  List<String> courseAssistants;
  String courseLocation;
  String courseDay;
  String courseTime;
  String courseDepartment;
  String courseHall;
  String required;

  CourseModel.fromMap(Map<String, dynamic> m) {
    courseName = m[CourseData.NAME];
    courseCode = m[CourseData.CODE];
    courseDoctor = m[CourseData.DOCTOR];
    courseHours = m[CourseData.CREDIT_HOURS];
    courseID = m[CourseData.ID];
//    m[CourseData.ASSISTANTS]?.forEach(
//          (e) => courseAssistants.add(
//        UserModel.fromMap(e),
//      ),
//    );
//    courseAssistants = m[CourseData.ASSISTANTS];
    courseLocation = m[CourseData.LOCATION];
    courseDay = m[CourseData.DAY];
    courseTime = m[CourseData.TIME];
    courseHall = m[CourseData.HALL];
    courseDepartment = m[CourseData.DEPARTMENT];
    required = m[CourseData.REQUIRED];
  }

  Map<String, dynamic> toMap() {
    return {
      CourseData.NAME: courseName,
      CourseData.CODE: courseCode,
      CourseData.DOCTOR: courseDoctor ?? '',
      CourseData.CREDIT_HOURS: courseHours,
      CourseData.ASSISTANTS: courseAssistants ?? [],
      CourseData.LOCATION: courseLocation ?? '',
      CourseData.DAY: courseDay ?? '',
      CourseData.TIME: courseTime ?? '',
      CourseData.HALL: courseHall ?? '',
      CourseData.DEPARTMENT: courseDepartment,
      CourseData.REQUIRED: required,
    };
  }

  CourseModel copyWith({
    String courseName,
    int courseHours,
    String courseCode,
    String courseDoctor,
    List<String> courseAssistants,
    String courseLocation,
    String courseDay,
    String courseTime,
    String courseDepartment,
    String courseHall,
    bool required,
  }) {
    return CourseModel(
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
      required: required ?? this.required,
    );
  }
}
