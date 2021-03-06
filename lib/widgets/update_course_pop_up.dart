import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/models/department_model.dart';
import 'package:elgam3a_admin/providers/departments_provider.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/screens/update_screens/update_course_screen.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class UpdateCoursePopUp extends StatefulWidget {
  @override
  _UpdateCoursePopUpState createState() => _UpdateCoursePopUpState();
}

class _UpdateCoursePopUpState extends State<UpdateCoursePopUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  DepartmentModel _department;
  CourseModel _course;

  _getCourse() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      // await context.read<DepartmentsProvider>().getCourseByCode(_courseCode);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateCourseScreen(),
        ),
      );
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
    final departments = context.watch<DepartmentsProvider>().departments;
    return AlertDialog(
      title: Text(
        'Update Course',
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
              validator: (v) => v == null ? 'You must choose faculty.' : null,
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
                validator: (v) => v == null ? 'You must choose course.' : null,
              ),
            },
            SizedBox(
              height: 24,
            ),
            RaisedButton(
              onPressed: _getCourse,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text('Update'),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
