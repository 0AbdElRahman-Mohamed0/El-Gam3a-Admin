import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/successfully_deleted_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';

class DeleteUserScreen extends StatefulWidget {
  @override
  _DeleteUserScreenState createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  String _univID;

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);

      final user =
          await context.read<UsersProvider>().getDataOfStudentByUnivID(_univID);
      if (user?.imagePath?.isNotEmpty ?? false) {
        await context.read<UsersProvider>().deleteImage(user.imagePath);
      }
      await context.read<UsersProvider>().deleteUser(user.univID);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => SuccessfullyDeletedPopUp(),
      );
      _formKey.currentState.reset();
      if (_autoValidate) setState(() => _autoValidate = false);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delete User',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
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
                  labelName: 'University ID',
                  hintText: 'Enter User University ID',
                  maxLength: 11,
                  onSaved: (id) {
                    _univID = id;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(
                        validationMessage: 'University ID is required.',
                      ),
                      MaxLengthRule(
                        11,
                        validationMessage:
                            'University ID should have 11 characters.',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
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
                        'Delete User',
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
