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
        children: [
          //TODO : two options to choose between
          //TODO : mtnsesh tzwdy el hashes bta3tek fe fire base admin w el 3ady
        ],
      ),
    );
  }
}
