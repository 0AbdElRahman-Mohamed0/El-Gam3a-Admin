import 'package:elgam3a_admin/models/course_model.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class CoursesProvider extends ChangeNotifier {
  List<CourseModel> courses = [];

  getCourses() {
    courses.add(
      CourseModel(
        courseDoctor: 'Ahmed Younis',
        courseCode: 'Cs 309',
        courseDay: 'Sunday',
        courseHall: 5,
        courseName: 'Data Science and Mining',
        courseTime: '3:00',
        courseLocation: 'El-shatby',
        required: true,
        courseAssistants: ['Sara Anwer', 'Yostina Nabil'],
        courseHours: 3,
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Shimaa Aly',
        courseCode: 'Cs 205',
        courseDay: 'Monday',
        courseHall: 2,
        courseName: 'Operating Systems',
        courseTime: '2:30',
        courseLocation: 'El-shatby',
        required: false,
        courseAssistants: ['Ahmed Ramadan', 'Ahmed Saleh'],
        courseHours: 2,
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Yasser Fouad',
        courseCode: 'Cs 401',
        courseDay: 'Monday',
        courseHall: 5,
        courseName: 'Graphics',
        courseTime: '12:00',
        courseLocation: 'Moharem bek',
        required: false,
        courseAssistants: ['Doha'],
        courseHours: 3,
      ),
    );
    courses.add(
      CourseModel(
        courseDoctor: 'Ahmed Younis',
        courseCode: 'Cs 309',
        courseDay: 'Sunday',
        courseHall: 5,
        courseName: 'Data Science and Mining',
        courseTime: '3:00',
        courseLocation: 'El-shatby',
        required: true,
        courseAssistants: ['Sara Anwer', 'Yostina Nabil'],
        courseHours: 3,
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Shimaa Aly',
        courseCode: 'Cs 205',
        courseDay: 'Monday',
        courseHall: 2,
        courseName: 'Operating Systems',
        courseTime: '2:30',
        courseLocation: 'El-shatby',
        required: false,
        courseAssistants: ['Ahmed Ramadan', 'Ahmed Saleh'],
        courseHours: 2,
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Yasser Fouad',
        courseCode: 'Cs 401',
        courseDay: 'Monday',
        courseHall: 5,
        courseName: 'Graphics',
        courseTime: '12:00',
        courseLocation: 'Moharem bek',
        required: false,
        courseAssistants: ['Doha'],
        courseHours: 3,
      ),
    );
    courses.add(
      CourseModel(
        courseDoctor: 'Ahmed Younis',
        courseCode: 'Cs 309',
        courseDay: 'Sunday',
        courseHall: 5,
        courseName: 'Data Science and Mining',
        courseTime: '3:00',
        courseLocation: 'El-shatby',
        required: true,
        courseAssistants: ['Sara Anwer', 'Yostina Nabil'],
        courseHours: 3,
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Shimaa Aly',
        courseCode: 'Cs 205',
        courseDay: 'Monday',
        courseHall: 2,
        courseName: 'Operating Systems',
        courseTime: '2:30',
        courseLocation: 'El-shatby',
        required: false,
        courseAssistants: ['Ahmed Ramadan', 'Ahmed Saleh'],
        courseHours: 2,
      ),
    );

    courses.add(
      CourseModel(
        courseDoctor: 'Yasser Fouad',
        courseCode: 'Cs 401',
        courseDay: 'Monday',
        courseHall: 5,
        courseName: 'Graphics',
        courseTime: '12:00',
        courseLocation: 'Moharem bek',
        required: false,
        courseAssistants: ['Doha'],
        courseHours: 3,
      ),
    );
    notifyListeners();
  }
}
