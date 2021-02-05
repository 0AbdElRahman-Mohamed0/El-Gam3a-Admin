import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class CoursesProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  List<CourseModel> courses = [];
  CourseModel course;
//  CourseModel course;

  Future<void> addCourse(CourseModel course) async {
    await _api.addCourse(course);
  }

  Future<CourseModel> getCourseByCode(String courseCode) async {
    course = await _api.getCourseByCode(courseCode);
    notifyListeners();
    return course;
  }

  Future<void> updateCourse(CourseModel course) async {
    await _api.updateCourse(course);
  }

  Future<void> deleteCourse(String courseCode) async {
    await _api.deleteCourse(courseCode);
  }

  getCourses() {
    courses.add(
      CourseModel(
        courseDoctor: 'Ahmed Younis',
        courseCode: 'Cs 309',
        courseDay: 'Sunday',
        courseHall: '5',
        courseName: 'Data Science and Mining',
        courseTime: '3:00',
        courseLocation: 'El-shatby',
        required: 'TRUE',
        courseAssistants: ['Sara Anwer', 'Yostina Nabil'],
        courseHours: '3',
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Shimaa Aly',
        courseCode: 'Cs 205',
        courseDay: 'Monday',
        courseHall: '2',
        courseName: 'Operating Systems',
        courseTime: '2:30',
        courseLocation: 'El-shatby',
        required: 'FALSE',
        courseAssistants: ['Ahmed Ramadan', 'Ahmed Saleh'],
        courseHours: '2',
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Yasser Fouad',
        courseCode: 'Cs 401',
        courseDay: 'Monday',
        courseHall: '5',
        courseName: 'Graphics',
        courseTime: '12:00',
        courseLocation: 'Moharem bek',
        required: 'FALSE',
        courseAssistants: ['Doha'],
        courseHours: '3',
      ),
    );
    courses.add(
      CourseModel(
        courseDoctor: 'Ahmed Younis',
        courseCode: 'Cs 309',
        courseDay: 'Sunday',
        courseHall: '5',
        courseName: 'Data Science and Mining',
        courseTime: '3:00',
        courseLocation: 'El-shatby',
        required: 'TRUE',
        courseAssistants: ['Sara Anwer', 'Yostina Nabil'],
        courseHours: '3',
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Shimaa Aly',
        courseCode: 'Cs 205',
        courseDay: 'Monday',
        courseHall: '2',
        courseName: 'Operating Systems',
        courseTime: '2:30',
        courseLocation: 'El-shatby',
        required: 'FALSE',
        courseAssistants: ['Ahmed Ramadan', 'Ahmed Saleh'],
        courseHours: '2',
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Yasser Fouad',
        courseCode: 'Cs 401',
        courseDay: 'Monday',
        courseHall: '5',
        courseName: 'Graphics',
        courseTime: '12:00',
        courseLocation: 'Moharem bek',
        required: 'FALSE',
        courseAssistants: ['Doha'],
        courseHours: '3',
      ),
    );
    courses.add(
      CourseModel(
        courseDoctor: 'Ahmed Younis',
        courseCode: 'Cs 309',
        courseDay: 'Sunday',
        courseHall: '5',
        courseName: 'Data Science and Mining',
        courseTime: '3:00',
        courseLocation: 'El-shatby',
        required: 'TRUE',
        courseAssistants: ['Sara Anwer', 'Yostina Nabil'],
        courseHours: '3',
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Shimaa Aly',
        courseCode: 'Cs 205',
        courseDay: 'Monday',
        courseHall: '2',
        courseName: 'Operating Systems',
        courseTime: '2:30',
        courseLocation: 'El-shatby',
        required: 'FALSE',
        courseAssistants: ['Ahmed Ramadan', 'Ahmed Saleh'],
        courseHours: '2',
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Yasser Fouad',
        courseCode: 'Cs 401',
        courseDay: 'Monday',
        courseHall: '5',
        courseName: 'Graphics',
        courseTime: '12:00',
        courseLocation: 'Moharem bek',
        required: 'FALSE',
        courseAssistants: ['Doha'],
        courseHours: '3',
      ),
    );
    notifyListeners();
  }
}
