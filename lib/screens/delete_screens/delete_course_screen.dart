import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/successfully_deleted_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/course_model.dart';
import '../../models/department_model.dart';
import '../../providers/departments_provider.dart';
import '../../widgets/drop_down.dart';

class DeleteCourseScreen extends StatefulWidget {
  @override
  _DeleteCourseScreenState createState() => _DeleteCourseScreenState();
}

class _DeleteCourseScreenState extends State<DeleteCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  DepartmentModel _department;
  CourseModel _course;

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await context
          .read<DepartmentsProvider>()
          .deleteCourse(_course, _department.id);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => SuccessfullyDeletedPopUp(),
      );
      _formKey.currentState.reset();
      if (_autoValidate) setState(() => _autoValidate = false);
    } on FirebaseException catch (e) {
      // TODO: handle all firebase exceptions using e.code
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
    final departments = context.watch<DepartmentsProvider>().departments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete Course',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Form(
          key: _formKey,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                  if (_department != null) ...{
                    SizedBox(
                      height: 24,
                    ),
                    DropDown<CourseModel>(
                      needSpace: false,
                      labelText: 'Course',
                      hintText: 'Select Course',
                      onChanged: (value) {},
                      list: _department.courses,
                      onSaved: (value) {
                        _course = value;
                      },
                      validator: (v) =>
                          v == null ? 'You must choose course.' : null,
                    ),
                  },
                  SizedBox(
                    height: 24,
                  ),
                ],
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
                      'Delete Course',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:elgam3a_admin/utilities/loading.dart';
// import 'package:elgam3a_admin/widgets/error_pop_up.dart';
// import 'package:elgam3a_admin/widgets/successfully_deleted_pop_up.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class DeleteCourseScreen extends StatefulWidget {
//   @override
//   _DeleteCourseScreenState createState() => _DeleteCourseScreenState();
// }
//
// class _DeleteCourseScreenState extends State<DeleteCourseScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//
//   String _courseCode;
//
//   _submit() async {
//     if (!_formKey.currentState.validate()) {
//       if (!_autoValidate) setState(() => _autoValidate = true);
//       return;
//     }
//     _formKey.currentState.save();
//     try {
//       LoadingScreen.show(context);
//       // await context.read<CoursesProvider>().deleteCourse(_courseCode);
//       Navigator.pop(context);
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => SuccessfullyDeletedPopUp(),
//       );
//       _formKey.currentState.reset();
//       if (_autoValidate) setState(() => _autoValidate = false);
//     } on FirebaseException catch (e) {
//       // TODO: handle all firebase exceptions using e.code
//       Navigator.of(context).pop();
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
//       return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Delete Course',
//             style: Theme.of(context).textTheme.headline3,
//           ),
//         ),
//         body: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
//           child: Form(
//             key: _formKey,
//             autovalidateMode: _autoValidate
//                 ? AutovalidateMode.always
//                 : AutovalidateMode.disabled,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 2.7),
//               child: Column(
//                 children: [
//                   TextDataField(
//                     labelName: 'Course Code',
//                     hintText: 'Enter Course Code',
//                     maxLength: 9,
//                     onSaved: (code) {
//                       _courseCode = code;
//                     },
//                     validator: Validator(
//                       rules: [
//                         RequiredRule(
//                           validationMessage: 'Course code is required.',
//                         ),
//                         MinLengthRule(
//                           9,
//                           validationMessage:
//                               'Course code should have 9 characters.',
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 50,
//                   ),
//                   GestureDetector(
//                     onTap: () => _submit(),
//                     child: Container(
//                       width: double.infinity,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         color: Theme.of(context).buttonColor,
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Delete Course',
//                           style: Theme.of(context).textTheme.headline3,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
// }
