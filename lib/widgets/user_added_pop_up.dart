import 'package:flutter/material.dart';

class UserAddedPopUp extends StatelessWidget {
  final String email;
  final String password;
  UserAddedPopUp({this.email, this.password});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('User added'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Email : ',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text('$email'),
            ],
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              Text(
                'Password : ',
                style: Theme.of(context).textTheme.headline1,
              ),
              Text('$password'),
            ],
          ),
          SizedBox(height: 24.0),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            color: Theme.of(context).buttonColor,
            textColor: Colors.white,
            child: Text('OK'),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
