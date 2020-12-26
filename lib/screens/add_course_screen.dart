import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/providers/courses_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddCourseScreen extends StatefulWidget {
  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _code;
  String _creditHours;
  String _department;
  String _required;

  bool departmentSelected = true;

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
      if (_department == null)
        setState(() {
          departmentSelected = false;
          _autoValidate = true;
        });
      if (_required == null)
        setState(() {
          requiredSelected = false;
          _autoValidate = true;
        });
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      final course = CourseModel(
        courseName: _name,
        courseCode: _code,
        courseHours: _creditHours,
        courseDepartment: _department,
        required: _required,
      );

      await context.read<CoursesProvider>().addCourse(course);
      Navigator.pop(context);
      Alert(
        context: context,
        title: 'Course added',
        desc: 'Name : $_name\nCode : $_code',
        style: AlertStyle(
          titleStyle: Theme.of(context).textTheme.headline6,
          descStyle: Theme.of(context).textTheme.headline1,
        ),
      ).show();
      _formKey.currentState.reset();
    } catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Course',
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
                            'Name should have at least 9 characters.',
                      ),
                    ],
                  ),
                ),
                TextDataField(
                  labelName: 'Code',
                  hintText: 'Enter Course Code',
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
                  onChanged: (value) {
                    _department = value;
                    departmentSelected = true;
                    setState(() {});
                  },
//                  validator: Validator(
//                    rules: [
//                      RequiredRule(
//                        validationMessage: 'Department is required.',
//                      ),
//                    ],
//                  ),
                  list: departments,
                  onSaved: (value) {
                    _department = value;
                    departmentSelected = true;
                    setState(() {});
                  },
                ),
                departmentSelected
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'You must choose department.',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: 21,
                ),
                DropDown(
                  needSpace: false,
                  labelText: 'Required',
                  hintText: 'Required?',
                  onChanged: (value) {
                    _required = value;
                    requiredSelected = true;
                    setState(() {});
                  },
//                  validator: Validator(
//                    rules: [
//                      RequiredRule(
//                        validationMessage: 'This field is required.',
//                      ),
//                    ],
//                  ),
                  list: required,
                  onSaved: (value) {
                    _required = value;
                    requiredSelected = true;
                    setState(() {});
                  },
                ),
                requiredSelected
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'You must choose required or not.',
                            style: TextStyle(
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        ],
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
                        'Add Course',
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
