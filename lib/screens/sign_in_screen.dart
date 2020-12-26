import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/screens/dashboard_screen.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _autoValidate = false;
  String _email;
  String _password;

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
        Alert(
          context: context,
          title: 'Not found',
          desc: 'No user found for that email.',
          type: AlertType.info,
          style: AlertStyle(
            titleStyle: Theme.of(context).textTheme.headline6,
            descStyle: Theme.of(context).textTheme.headline2,
          ),
          buttons: [
            DialogButton(
              color: Theme.of(context).buttonColor,
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ).show();
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      Alert(
        context: context,
        title: 'Not found',
        desc: 'No user found, Wrong email or password.',
        type: AlertType.info,
        style: AlertStyle(
          titleStyle: Theme.of(context).textTheme.headline6,
          descStyle: Theme.of(context).textTheme.headline2,
        ),
        buttons: [
          DialogButton(
            color: Theme.of(context).buttonColor,
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.headline3,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ).show();
    } catch (e, s) {
      Navigator.pop(context);
      print(s);
      Alert(
        context: context,
        title: '',
        desc: 'Something went wrong please retry later.',
        style: AlertStyle(
          descStyle: Theme.of(context).textTheme.headline2,
        ),
        buttons: [
          DialogButton(
            color: Theme.of(context).buttonColor,
            child: Text(
              'OK',
              style: Theme.of(context).textTheme.headline3,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.6),
        child: Stack(
          children: [
            // Positioned(
            //   top: 62.4,
            //   left: 18.3,
            //   child: IconButton(
            //     onPressed: () {
            //       print('Pressed');
            //     },
            //     icon: SvgPicture.asset('assets/svg/g8738.svg'),
            //   ),
            // ),
            Form(
              key: _formKey,
              autovalidateMode: _autoValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign in',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 40.2,
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
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: () => _submit(),
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
          ],
        ),
      ),
    );
  }
}
