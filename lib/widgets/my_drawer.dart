import 'package:elgam3a_admin/screens/add_screens/add_course_screen.dart';
import 'package:elgam3a_admin/screens/add_screens/add_hall_screen.dart';
import 'package:elgam3a_admin/screens/add_screens/add_user_screen.dart';
import 'package:elgam3a_admin/screens/delete_screens/delete_course_screen.dart';
import 'package:elgam3a_admin/screens/delete_screens/delete_hall_screen.dart';
import 'package:elgam3a_admin/screens/delete_screens/delete_user_screen.dart';
import 'package:elgam3a_admin/widgets/drawer_option.dart';
import 'package:elgam3a_admin/widgets/update_user_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/update_screens/update_course_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        Icon(
                          FontAwesomeIcons.snowman,
                          color: Theme.of(context).scaffoldBackgroundColor,
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
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            DrawerOption(
              optionName: 'ADD USER',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUserScreen(),
                ),
              ),
            ),
            DrawerOption(
              optionName: 'ADD COURSE',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCourseScreen(),
                ),
              ),
            ),
            DrawerOption(
              optionName: 'ADD HALL',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddHallScreen(),
                ),
              ),
            ),
            DrawerOption(
              update: true,
              optionName: 'UPDATE USER',
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => UpdateUserPopUp()),
            ),
            DrawerOption(
              update: true,
              optionName: 'UPDATE COURSE',
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) => UpdateCoursePopUp());
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateCourseScreen(),
                  ),
                );
              },
            ),
            DrawerOption(
              remove: true,
              optionName: 'DELETE USER',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteUserScreen(),
                ),
              ),
            ),
            DrawerOption(
              remove: true,
              optionName: 'DELETE COURSE',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteCourseScreen(),
                ),
              ),
            ),
            DrawerOption(
              remove: true,
              optionName: 'DELETE HALL',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeleteHallScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
