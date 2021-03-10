import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddDepartmentScreen extends StatefulWidget {
  @override
  _AddDepartmentScreenState createState() => _AddDepartmentScreenState();
}

class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _depName;
  String _courseName;
  String _code;
  int _creditHours;
  bool _isRequired = false;

  List<CourseModel> _courses = [];

  _addDepartment() async {
    LoadingScreen.show(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference data =
        await firestore.collection('departments_data').add({
      'id': '',
      'name': _depName,
      'courses': _courses.map((hall) => hall.toMap()).toList(),
    });

    await firestore
        .collection('departments_data')
        .doc(data.id)
        .update({'id': data.id});
    Navigator.pop(context);
    _courses = [];
    setState(() {});
  }

  _addCourse() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add course',
          style: Theme.of(context).textTheme.headline6,
        ),
        content: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.7),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Course Name',
                    ),
                    onChanged: (name) {
                      _courseName = name;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  TextFormField(
                    maxLength: 9,
                    decoration: InputDecoration(
                      labelText: 'Code',
                      hintText: 'Enter Course Code',
                    ),
                    onChanged: (code) {
                      _code = code;
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[1-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: 'Credit Hours',
                      hintText: 'Enter Course Credit Hours',
                    ),
                    onChanged: (hours) {
                      _creditHours = num.parse(hours);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Theme.of(context).primaryColor,
                        value: _isRequired,
                        onChanged: (value) {
                          _isRequired = value;
                          print("isRequired $_isRequired");
                          setState(() {});
                        },
                      ),
                      Text(
                        'Is required ?',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 21,
                  ),
                  InkWell(
                    onTap: () {
                      _courses.add(CourseModel(
                        courseName: _courseName,
                        courseHours: _creditHours,
                        courseCode: _code,
                        isRequired: _isRequired,
                      ));
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).buttonColor,
                      ),
                      child: Center(
                        child: Text(
                          'Add Course',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'name',
                hintText: 'Enter name',
              ),
              onChanged: (name) {
                _depName = name;
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            ..._courses
                .map(
                  (e) => Column(
                    children: [
                      Text('course ${e.courseName}'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
                .toList(),
            RaisedButton(
              onPressed: _addCourse,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text('Add course'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: _addDepartment,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text('Add department'),
            ),
          ],
        ),
      ),
    );
  }
}
