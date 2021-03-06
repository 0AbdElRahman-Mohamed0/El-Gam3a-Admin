import 'package:elgam3a_admin/models/department_model.dart';
import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/providers/departments_provider.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:elgam3a_admin/widgets/user_added_pop_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _univID;
  String _phoneNumber;
  String _email;
  String _division;
  String _department;
  String _type;

  List<String> divisions = [
    'Natural Science',
    'Biology',
    'Geology',
  ];

  // List<String> departments = [
  //   'Mathematics',
  //   'Statistics',
  //   'Computer Science',
  //   'Chemistry',
  //   'Physics',
  //   'Biophysics',
  //   'Microbiology',
  //   'Biochemistry',
  //   'Geology',
  // ];

  List<String> types = [
    'Student',
    'Professor',
  ];

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      final user = UserModel(
        name: _name.trim(),
        type: _type,
        phoneNumber: _phoneNumber,
        email: _email.trim(),
        division: _division,
        department: _department,
        univID: _univID,
      );
      final pass = context.read<UsersProvider>().getRandomPassword();
      await context.read<UsersProvider>().addNewUser(user, pass);
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => UserAddedPopUp(
          email: _email,
          password: pass,
        ),
      );
      _formKey.currentState.reset();
      _department = null;
      _division = null;
      _type = null;
      _autoValidate = false;
      setState(() {});
    } on FirebaseException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message: 'Something went wrong, please try again \n ${e.message}'),
      );
    } catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message:
                'Something went wrong, please try again \n ${e.toString()}'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final departments = context.watch<DepartmentsProvider>().departments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New User',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
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
                TextDataField(
                  autofocus: true,
                  labelName: 'Name',
                  hintText: 'Enter Name',
                  onSaved: (name) {
                    _name = name;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(
                        validationMessage: 'Name is required.',
                      ),
                      MinLengthRule(
                        3,
                        validationMessage:
                            'Name should have at least 3 characters.',
                      ),
                    ],
                  ),
                ),
                TextDataField(
                  maxLength: 11,
                  labelName: 'Phone number',
                  hintText: 'Enter Phone Number',
                  keyboardType: TextInputType.number,
                  onSaved: (phoneNumber) {
                    _phoneNumber = phoneNumber;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(
                        validationMessage: 'Phone number is required.',
                      ),
                      MinLengthRule(11,
                          validationMessage:
                              'Phone number should be 11 number.'),
                    ],
                  ),
                ),
                TextDataField(
                  keyboardType: TextInputType.emailAddress,
                  labelName: 'Email',
                  hintText: 'Enter Email',
                  onSaved: (email) {
                    _email = email;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(validationMessage: 'Email is required.'),
                    ],
                  ),
                ),
                DropDown(
                  needSpace: false,
                  labelText: 'User type',
                  hintText: 'Select user type',
                  list: types,
                  onChanged: (type) {
                    _type = type;
                    setState(() {});
                  },
                  onSaved: (type) {
                    _type = type;
                  },
                  validator: (String v) =>
                      v == null ? 'You must choose user type.' : null,
                ),
                SizedBox(
                  height: 21,
                ),
                TextDataField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  labelName: 'User ID',
                  hintText: 'Enter user id',
                  onSaved: (univID) {
                    _univID = univID;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(validationMessage: 'User ID is required.'),
                      MinLengthRule(11,
                          validationMessage: 'User ID should be 11 number.'),
                    ],
                  ),
                ),
                if (_type == 'Student') ...{
                  DropDown(
                    needSpace: false,
                    labelText: 'Division',
                    hintText: 'Select division',
                    list: divisions,
                    onChanged: (division) {
                      _division = division;
                      setState(() {});
                    },
                    onSaved: (division) {
                      _division = division;
                    },
                    validator: (String v) =>
                        v == null ? 'You must choose division.' : null,
                  ),
                },
                if (_type == 'Professor') ...{
                  DropDown<DepartmentModel>(
                    needSpace: false,
                    labelText: 'Department',
                    hintText: 'Select department',
                    list: departments,
                    onChanged: (department) {
                      _department = department.name;
                      setState(() {});
                    },
                    onSaved: (department) {
                      _department = department.name;
                    },
                    validator: (v) =>
                        v == null ? 'You must choose department.' : null,
                  ),
                },
                SizedBox(
                  height: 21,
                ),
                GestureDetector(
                  onTap: () => _submit(),
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).buttonColor,
                    ),
                    child: Center(
                      child: Text(
                        'Add User',
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
    );
  }
}
