import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/screens/update_screens/update_user_screen.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class UpdateUserPopUp extends StatefulWidget {
  @override
  _UpdateUserPopUpState createState() => _UpdateUserPopUpState();
}

class _UpdateUserPopUpState extends State<UpdateUserPopUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String _univID;

  _getUser() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await context.read<UsersProvider>().getDataOfStudentByUnivID(_univID);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateUserScreen(),
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
        'User ID',
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
              hintText: 'Enter user id',
              onSaved: (univID) {
                _univID = univID;
              },
              validator: Validator(
                rules: [
                  RequiredRule(validationMessage: 'Student ID is required.'),
                  MinLengthRule(11,
                      validationMessage: 'Student ID should be 11 number.'),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _getUser,
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
