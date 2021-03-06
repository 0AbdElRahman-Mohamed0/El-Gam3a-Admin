import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/providers/departments_provider.dart';
import 'package:elgam3a_admin/providers/faculities_provider.dart';
import 'package:elgam3a_admin/screens/dashboard_screen.dart';
import 'package:elgam3a_admin/screens/sign_in_screen.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _isSignIn();
    _getDepartments();
    _getFaculties();
  }

  _isSignIn() async {
    await Future.delayed(Duration(seconds: 9));

    final signIn = context.read<AuthProvider>().isSignedIn();

    if (signIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }

  _getFaculties() async {
    try {
      await context.read<FacultiesProvider>().getFaculties();
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message: 'Something went wrong, please try again \n ${e.message}'),
      );
    } catch (e, s) {
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

  _getDepartments() async {
    try {
      await context.read<DepartmentsProvider>().getDepartments();
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message: 'Something went wrong, please try again \n ${e.message}'),
      );
    } catch (e, s) {
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
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        // color: Theme.of(context).buttonColor,
        child: Center(
          child: Hero(
            tag: 'logo',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/ph.png',
                  color: Theme.of(context).primaryColor,
                  height: 120.0,
                  width: 120.0,
                ),
                Text(
                  'El-Gam3a',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 64),
                ),
                Text(
                  'Admin',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
