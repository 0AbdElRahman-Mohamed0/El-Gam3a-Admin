import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/screens/dashboard_screen.dart';
import 'package:elgam3a_admin/screens/sign_in_screen.dart';
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
