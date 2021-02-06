import 'package:elgam3a_admin/providers/courses_provider.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/screens/update_course_screen.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class UpdateCoursePopUp extends StatefulWidget {
  @override
  _UpdateCoursePopUpState createState() => _UpdateCoursePopUpState();
}

class _UpdateCoursePopUpState extends State<UpdateCoursePopUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _courseCode;

  _getCourse() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await context.read<CoursesProvider>().getCourseByCode(_courseCode);
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
    return AlertDialog(
      title: Text(
        'Course code',
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Form(
        key: _formKey,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextDataField(
              maxLength: 11,
              keyboardType: TextInputType.number,
              labelName: '',
              hintText: 'Enter course code',
              onSaved: (courseCode) {
                _courseCode = courseCode;
              },
              validator: Validator(
                rules: [
                  RequiredRule(validationMessage: 'Course code is required.'),
                  MinLengthRule(9,
                      validationMessage: 'Course code should be 9 number.'),
                ],
              ),
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
