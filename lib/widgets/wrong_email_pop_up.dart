import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class WrongEmailPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        'Not found',
        style: Theme.of(context).textTheme.headline6,
      ),
      content: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          Text(
            'No user found, Wrong email or password.',
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 24.0),
          RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('OK'),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
