import 'package:flutter/material.dart';

class AddUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New User',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: center,
        children: [
          Container(
            child: Icon(Icons.close),
          ),
          Container(
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
