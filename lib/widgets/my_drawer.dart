import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/screens/add_course_screen.dart';
import 'package:elgam3a_admin/screens/add_user_screen.dart';
import 'package:elgam3a_admin/screens/delete_course_screen.dart';
import 'package:elgam3a_admin/screens/delete_user_screen.dart';
import 'package:elgam3a_admin/screens/update_user_screen.dart';
import 'package:elgam3a_admin/widgets/drawer_option.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:elgam3a_admin/widgets/update_user_pop_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyDrawer extends StatelessWidget {
  String _univID;
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserScreen(),
                  ),
                );
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
                showDialog(
                    context: context,
                    builder: (BuildContext context) => UpdateUserPopUp());
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
    );
  }
}
