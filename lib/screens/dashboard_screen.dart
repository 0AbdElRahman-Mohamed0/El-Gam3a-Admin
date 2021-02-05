import 'package:elgam3a_admin/widgets/my_drawer.dart';
import 'package:flutter/material.dart';

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
      drawer: MyDrawer(),
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
