import 'package:flutter/cupertino.dart' hide FontWeight;
import 'package:flutter/material.dart' hide FontWeight;

class SuccessfullyDeletedPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Successful'),
      content: Column(
        children: <Widget>[
          SizedBox(height: 24.0),
          Text(
            'Data deleted successfully',
            style: Theme.of(context).textTheme.headline1,
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
