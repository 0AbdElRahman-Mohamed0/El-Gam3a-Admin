import 'dart:io';

import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/screens/dashboard_screen.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/wrong_email_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _autoValidate = false;
  String _email;
  String _password;
  bool isWeb;

  @override
  void initState() {
    super.initState();
    _checkPlatform();
  }

  _checkPlatform() {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        isWeb = false;
      } else {
        isWeb = true;
      }
    } catch (e) {
      isWeb = true;
    }
  }

  _submit() async {
    if (!_formKey.currentState.validate()) {
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      if (_email.contains('@el-gam3a.com')) {
        LoadingScreen.show(context);
        await context.read<AuthProvider>().logIn(_email, _password);
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
            (route) => false);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => WrongEmailPopUp(),
        );
      }
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) => WrongEmailPopUp(),
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
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Padding(
              padding: isWeb
                  ? EdgeInsets.symmetric(vertical: 50.0, horizontal: 200)
                  : EdgeInsets.symmetric(vertical: 50.0, horizontal: 12),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    SvgPicture.asset(
                      'assets/svg/logo_admin.svg',
                      height: 240,
                      width: 240,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Sign in',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          'Sign in using your email',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(
                          height: 10.1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.1),
                          child: TextFormField(
                            onSaved: (email) {
                              _email = email;
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: Validator<String>(
                              rules: [
                                RequiredRule(
                                  validationMessage: 'Email is required.',
                                ),
                                EmailRule(
                                  validationMessage: 'This email is not true.',
                                ),
                              ],
                            ),
                            decoration: InputDecoration(
                              labelText: 'Email',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 28.8,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.1),
                          child: TextFormField(
                            obscureText: true,
                            onSaved: (password) {
                              _password = password;
                            },
                            validator: Validator<String>(
                              rules: [
                                RequiredRule(
                                  validationMessage: 'Password is required.',
                                ),
                                MinLengthRule(
                                  6,
                                  validationMessage:
                                      'Password should contains 6 characters at least.',
                                ),
                              ],
                            ),
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: _submit,
                      child: Container(
                        width: double.infinity,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            'Login',
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
    );
  }
}
