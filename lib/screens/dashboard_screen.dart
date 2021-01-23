import 'package:elgam3a_admin/screens/add_course_screen.dart';
import 'package:elgam3a_admin/screens/add_doctor_screen.dart';
import 'package:elgam3a_admin/screens/add_student_screen.dart';
import 'package:elgam3a_admin/screens/add_user_screen.dart';
import 'package:elgam3a_admin/screens/delete_course_screen.dart';
import 'package:elgam3a_admin/screens/delete_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      drawer: SizedBox(
        width: double.infinity,
        child: Drawer(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/g4130.svg',
                          ),
                          SizedBox(
                            height: 14.0,
                          ),
                          Text(
                            'EL-GAM3A\nADMIN',
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SafeArea(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.close,
                            color: Theme.of(context).iconTheme.color,
                            size: Theme.of(context).iconTheme.size,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              DrawerOption(
                optionName: 'ADD USER',
                onPressed: () {
                  Alert(
                    context: context,
                    title: 'Choose user type.',
                    style: AlertStyle(
                      titleStyle: Theme.of(context).textTheme.headline6,
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddDoctorScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Doctor',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      DialogButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddStudentScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Student',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ],
                  ).show();
                },
              ),
              DrawerOption(
                optionName: 'ADD COURSE',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCourseScreen(),
                    ),
                  );
                },
              ),
              DrawerOption(
                update: true,
                optionName: 'UPDATE USER',
                onPressed: () {
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProductsScreen(),
                  //   ),
                  // );
                },
              ),
              DrawerOption(
                update: true,
                optionName: 'UPDATE COURSE',
                onPressed: () {
                  //   return Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BrandsScreen(),
                  //   ),
                  // );
                },
              ),
              DrawerOption(
                remove: true,
                optionName: 'REMOVE USER',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteUserScreen(),
                    ),
                  );
                },
              ),
              DrawerOption(
                remove: true,
                optionName: 'REMOVE COURSE',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteCourseScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 23.2,
            ),
            Text(
              'Welcome to El-Gam3a\nby StarTeam Admin.',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  DrawerOption({
    this.optionName,
    this.onPressed,
    this.remove = false,
    this.update = false,
  });
  final String optionName;
  final Function onPressed;
  final bool remove;
  final bool update;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24, left: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onPressed,
        child: Row(
          children: [
            remove
                ? Icon(
                    Icons.remove_circle,
                    color: Theme.of(context).errorColor,
                    size: 28,
                  )
                : update
                    ? Icon(
                        Icons.update,
                        color: Theme.of(context).accentColor,
                        size: 28,
                      )
                    : Icon(
                        Icons.add_circle,
                        color: Colors.green[300],
                        size: 28,
                      ),
            SizedBox(width: 24),
            Text(
              optionName,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
