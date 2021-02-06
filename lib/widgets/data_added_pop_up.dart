import 'package:flutter/material.dart';

class DataAddedPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Successful'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Data added Successfully',
            style: Theme.of(context).textTheme.headline1,
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
