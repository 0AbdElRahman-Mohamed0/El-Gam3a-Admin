import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/models/department_model.dart';
import 'package:elgam3a_admin/providers/departments_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/data_added_pop_up.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCourseScreen extends StatefulWidget {
  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _code;
  int _creditHours;
  DepartmentModel _department;
  bool _isRequired = false;

  // List<String> departments = [
  //   'Mathematics',
  //   'Statistics',
  //   'Computer Science',
  //   'Chemistry',
  //   'Physics',
  //   'Biophysics',
  //   'Microbiology',
  //   'Biochemistry',
  //   'Geology',
  // ];

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      print('Add course screen before');
      final course = CourseModel(
        courseName: _name,
        courseCode: _code,
        courseHours: _creditHours,
        // courseDepartment: _department,
        isRequired: _isRequired,
      );

      await context
          .read<DepartmentsProvider>()
          .addCourse(course, _department.id);
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (BuildContext context) => DataAddedPopUp());
      if (_autoValidate) setState(() => _autoValidate = false);
      _isRequired = false;
      print('Add course screen after');
      setState(() {});
      _formKey.currentState.reset();
    } on FirebaseException catch (e) {
      Navigator.pop(context);
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
    final departments = context.watch<DepartmentsProvider>().departments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Course',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Padding(
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
                      DropDown<DepartmentModel>(
                        needSpace: false,
                        labelText: 'Department',
                        hintText: 'Select department',
                        onChanged: (value) {
                          _department = value;
                          setState(() {});
                        },
                        list: departments,
                        onSaved: (value) {
                          _department = value;
                        },
                        validator: (v) =>
                            v == null ? 'You must choose department.' : null,
                      ),
                      SizedBox(
                        height: 24,
                      ),
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
                                  'Name should have at least 3 characters.',
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
                        validator: Validator(
                          rules: [
                            RequiredRule(
                              validationMessage: 'Code is required.',
                            ),
                            MinLengthRule(
                              3,
                              validationMessage:
                                  'Code should have at least 3 characters.',
                            ),
                          ],
                        ),
                      ),
                      TextDataField(
                        maxLength: 1,
                        labelName: 'Credit Hours',
                        hintText: 'Enter Course Credit Hours',
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[1-3]')),
                        ],
                        onSaved: (hours) {
                          _creditHours = num.parse(hours);
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
                      Row(
                        children: [
                          Checkbox(
                            activeColor: Theme.of(context).primaryColor,
                            value: _isRequired,
                            onChanged: (value) {
                              _isRequired = value;
                              setState(() {});
                            },
                          ),
                          Text(
                            'Is required ?',
                            style: Theme.of(context).textTheme.headline1,
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
          ),
        ),
      ),
    );
  }
}

// import 'package:elgam3a_admin/models/course_model.dart';
// import 'package:elgam3a_admin/providers/courses_provider.dart';
// import 'package:elgam3a_admin/utilities/loading.dart';
// import 'package:elgam3a_admin/widgets/data_added_pop_up.dart';
// import 'package:elgam3a_admin/widgets/drop_down.dart';
// import 'package:elgam3a_admin/widgets/error_pop_up.dart';
// import 'package:elgam3a_admin/widgets/text_data_field.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flrx_validator/flrx_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class AddCourseScreen extends StatefulWidget {
//   @override
//   _AddCourseScreenState createState() => _AddCourseScreenState();
// }
//
// class _AddCourseScreenState extends State<AddCourseScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//
//   String _name;
//   String _code;
//   int _creditHours;
//   String _department;
//   bool _isRequired = false;
//
//   List<String> departments = [
//     'Mathematics',
//     'Statistics',
//     'Computer Science',
//     'Chemistry',
//     'Physics',
//     'Biophysics',
//     'Microbiology',
//     'Biochemistry',
//     'Geology',
//   ];
//
//   _submit() async {
//     if (!_formKey.currentState.validate()) {
//       if (!_autoValidate) setState(() => _autoValidate = true);
//       return;
//     }
//     _formKey.currentState.save();
//     try {
//       LoadingScreen.show(context);
//       final course = CourseModel(
//         courseName: _name,
//         courseCode: _code,
//         courseHours: _creditHours,
//         courseDepartment: _department,
//         isRequired: _isRequired,
//       );
//
//       await context.read<CoursesProvider>().addCourse(course);
//       Navigator.pop(context);
//       showDialog(
//           context: context,
//           builder: (BuildContext context) => DataAddedPopUp());
//       _formKey.currentState.reset();
//     } on FirebaseException catch (e) {
//       Navigator.pop(context);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => ErrorPopUp(
//             message: 'Something went wrong, please try again \n ${e.message}'),
//       );
//     } catch (e, s) {
//       Navigator.pop(context);
//       print(e);
//       print(s);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => ErrorPopUp(
//             message:
//                 'Something went wrong, please try again \n ${e.toString()}'),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add Course',
//           style: Theme.of(context).textTheme.headline3,
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//         child: Form(
//           key: _formKey,
//           autovalidateMode: _autoValidate
//               ? AutovalidateMode.always
//               : AutovalidateMode.disabled,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 2.7),
//             child: Column(
//               children: [
//                 TextDataField(
//                   labelName: 'Name',
//                   hintText: 'Enter Course Name',
//                   onSaved: (name) {
//                     _name = name;
//                   },
//                   validator: Validator(
//                     rules: [
//                       RequiredRule(
//                         validationMessage: 'Name is required.',
//                       ),
//                       MinLengthRule(
//                         3,
//                         validationMessage:
//                             'Name should have at least 3 characters.',
//                       ),
//                     ],
//                   ),
//                 ),
//                 TextDataField(
//                   maxLength: 9,
//                   labelName: 'Code',
//                   hintText: 'Enter Course Code',
//                   onSaved: (code) {
//                     _code = code;
//                   },
//                   keyboardType: TextInputType.number,
//                   validator: Validator(
//                     rules: [
//                       RequiredRule(
//                         validationMessage: 'Code is required.',
//                       ),
//                       MinLengthRule(
//                         9,
//                         validationMessage: 'Code should have 9 digits.',
//                       ),
//                     ],
//                   ),
//                 ),
//                 TextDataField(
//                   labelName: 'Credit Hours',
//                   hintText: 'Enter Course Credit Hours',
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp('[1-9]')),
//                   ],
//                   onSaved: (hours) {
//                     _creditHours = num.parse(hours);
//                   },
//                   validator: Validator(
//                     rules: [
//                       RequiredRule(
//                         validationMessage: 'Credit hours is required.',
//                       ),
//                       MaxLengthRule(
//                         1,
//                         validationMessage:
//                             'Credit hours should have only 1 characters.',
//                       ),
//                     ],
//                   ),
//                 ),
//                 DropDown(
//                   needSpace: false,
//                   labelText: 'Department',
//                   hintText: 'Select department',
//                   onChanged: (value) {},
//                   list: departments,
//                   onSaved: (value) {
//                     _department = value;
//                   },
//                   validator: (String v) =>
//                       v == null ? 'You must choose department.' : null,
//                 ),
//                 SizedBox(
//                   height: 21,
//                 ),
//                 Row(
//                   children: [
//                     Checkbox(
//                       activeColor: Theme.of(context).primaryColor,
//                       value: _isRequired,
//                       onChanged: (value) {
//                         _isRequired = value;
//                         setState(() {});
//                       },
//                     ),
//                     Text(
//                       'Is required ?',
//                       style: Theme.of(context).textTheme.headline1,
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 21,
//                 ),
//                 GestureDetector(
//                   onTap: () => _submit(),
//                   child: Container(
//                     width: double.infinity,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Theme.of(context).buttonColor,
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Add Course',
//                         style: Theme.of(context).textTheme.headline3,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
