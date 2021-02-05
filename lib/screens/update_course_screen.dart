import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/providers/courses_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/successfully_update_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateCourseScreen extends StatefulWidget {
  @override
  _UpdateCourseScreenState createState() => _UpdateCourseScreenState();
}

class _UpdateCourseScreenState extends State<UpdateCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _code;
  String _creditHours;
  String _department;
  String _required;

  List<String> departments = [
    'Mathematics',
    'Statistics',
    'Computer Science',
    'Chemistry',
    'Physics',
    'Biophysics',
    'Microbiology',
    'Biochemistry',
    'Geology',
  ];

  bool requiredSelected = true;

  List<String> required = [
    'TRUE',
    'FALSE',
  ];

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      CourseModel course = context.read<CoursesProvider>().course;
      course = course.copyWith(
        courseName: _name,
        courseCode: _code,
        courseHours: _creditHours,
        courseDepartment: _department,
        required: _required,
      );
      await context.read<CoursesProvider>().updateCourse(course);
      Navigator.pop(context);
      await showDialog(
          context: context,
          builder: (BuildContext context) => SuccessfullyUpdatePopUp());
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message: 'Something went wrong, please try again \n ${e.message}'),
      );
    } catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message:
                'Something went wrong, please try again \n ${e.toString()}'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final course = context.watch<CoursesProvider>().course;
    print('hsada ${course.courseID}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Course',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.7),
            child: Column(
              children: [
                TextDataField(
                  labelName: 'Name',
                  hintText: 'Enter Course Name',
                  initialValue: course.courseName,
                  onSaved: (name) {
                    _name = name;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(
                        validationMessage: 'Name is required.',
                      ),
                      MinLengthRule(
                        3,
                        validationMessage:
                            'Name should have at least 3 characters.',
                      ),
                    ],
                  ),
                ),
                TextDataField(
                  labelName: 'Code',
                  hintText: 'Enter Course Code',
                  initialValue: course.courseCode,
                  onSaved: (code) {
                    _code = code;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  validator: Validator(
                    rules: [
                      RequiredRule(
                        validationMessage: 'Code is required.',
                      ),
                      MinLengthRule(
                        9,
                        validationMessage:
                            'Code should have at least 9 characters.',
                      ),
                    ],
                  ),
                ),
                TextDataField(
                  labelName: 'Credit Hours',
                  hintText: 'Enter Course Credit Hours',
                  initialValue: course.courseHours,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[1-9]')),
                  ],
                  onSaved: (hours) {
                    _creditHours = hours;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(
                        validationMessage: 'Credit hours is required.',
                      ),
                      MaxLengthRule(
                        1,
                        validationMessage:
                            'Credit hours should have only 1 characters.',
                      ),
                    ],
                  ),
                ),
                DropDown(
                  needSpace: false,
                  labelText: 'Department',
                  hintText: 'Select department',
                  value: course.courseDepartment ?? _department,
                  onChanged: (value) {
                    _department = value;
                    setState(() {});
                  },
                  list: departments,
                  onSaved: (value) {
                    _department = value;
                  },
                  validator: (String v) =>
                      v == null ? 'You must choose department.' : null,
                ),
                SizedBox(
                  height: 21,
                ),
                DropDown(
                  needSpace: false,
                  labelText: 'Required',
                  hintText: 'Required?',
                  value: course.required ?? _required,
                  onChanged: (value) {
                    _required = value;
                    setState(() {});
                  },
                  list: required,
                  onSaved: (value) {
                    _required = value;
                  },
                ),
                SizedBox(
                  height: 21,
                ),
                GestureDetector(
                  onTap: () => _submit(),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).buttonColor,
                    ),
                    child: Center(
                      child: Text(
                        'Update Course',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
