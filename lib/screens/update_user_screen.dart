import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _univID;
  String _phoneNumber;
  String _email;
  String _division;
  String _department;
  String _completedHours;
  String _registeredHours;
  String _cgpa;

  bool departmentSelected;

  List<String> departments = [
    'Mathematics',
    'Statistics',
    'Computer Science',
    'Chemistry',
    'Physics',
    'Biophysics',
    'Microbiology',
    'Biochemistry',
    'Geology',
  ];

  bool divisionSelected = true;

  List<String> divisions = [
    'Natural Science',
    'Biology',
    'Geology',
  ];

  _submit() async {
    UserModel user = context.read<AuthProvider>().userModel;

    if (!_formKey.currentState.validate()) {
      if (_division == null) divisionSelected = false;
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      user = user.copyWith(
        name: _name,
        phoneNumber: _phoneNumber,
        email: _email,
        completedHours: _completedHours,
        gpa: _cgpa,
        registeredHours: _registeredHours,
        division: _division,
        department: _department,
      );
      await context.read<AuthProvider>().updateUser(user);

      Navigator.pop(context);
      Alert(
        context: context,
        title: 'User updated',
        style: AlertStyle(
          titleStyle: Theme.of(context).textTheme.headline6,
          descStyle: Theme.of(context).textTheme.headline1,
        ),
      ).show();
      _formKey.currentState.reset();
    } catch (e, s) {
      Navigator.pop(context);
      Alert(context: context, title: 'something went wrong! please try again')
          .show();
      print('error $e');
      print('trace $s');
    }
  }

//  @override
//  void initState() {
//    super.initState();
//    Future.wait([context.read<AuthProvider>().getUserData()]);
//    UserModel user = context.read<AuthProvider>().userModel;
//  }

  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<AuthProvider>().userModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update User',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: user == null
          ? LoadingWidget()
          : SingleChildScrollView(
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
                        labelName: 'Name',
                        hintText: 'Enter Name',
                        initialValue: user.name,
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
                                  'Name should have at least 9 characters.',
                            ),
                          ],
                        ),
                      ),
                      TextDataField(
                        labelName: 'Phone number',
                        hintText: 'Enter Phone Number',
                        initialValue: user.phoneNumber,
                        keyboardType: TextInputType.number,
                        inputFormatters: [],
                        onSaved: (phoneNumber) {
                          _phoneNumber = phoneNumber;
                        },
                        validator: Validator(
                          rules: [
                            RequiredRule(
                              validationMessage: 'Phone number is required.',
                            ),
                          ],
                        ),
                      ),
                      TextDataField(
                        keyboardType: TextInputType.emailAddress,
                        labelName: 'Email',
                        hintText: 'Enter Email',
                        initialValue: user.email,
                        onSaved: (email) {
                          _email = email;
                        },
                        validator: Validator(
                          rules: [
                            RequiredRule(
                                validationMessage: 'Email is required.'),
                          ],
                        ),
                      ),
                      TextDataField(
                        keyboardType: TextInputType.number,
                        labelName: 'Completed hours',
                        hintText: 'Enter completed hours',
                        initialValue: user.completedHours,
                        onSaved: (hours) {
                          _completedHours = hours;
                        },
                        validator: Validator(
                          rules: [
                            RequiredRule(
                                validationMessage:
                                    'Completed hours is required.'),
                          ],
                        ),
                      ),
                      TextDataField(
                        keyboardType: TextInputType.number,
                        labelName: 'CGPA',
                        hintText: 'Enter CGPA',
                        initialValue: user.gpa,
                        onSaved: (cgpa) {
                          _cgpa = cgpa;
                        },
                        validator: Validator(
                          rules: [
                            RequiredRule(
                                validationMessage: 'CGPA is required.'),
                          ],
                        ),
                      ),
                      TextDataField(
                        keyboardType: TextInputType.number,
                        labelName: 'Registered hours',
                        hintText: 'Enter registered hours',
                        initialValue: user.registeredHours,
                        onSaved: (hours) {
                          _registeredHours = hours;
                        },
                        validator: Validator(
                          rules: [
                            RequiredRule(
                                validationMessage:
                                    'Registered hours is required.'),
                          ],
                        ),
                      ),
                      DropDown(
                        needSpace: false,
                        labelText: 'Division',
                        hintText: 'Select division',
                        value: user.division,
                        onChanged: (value) {
                          _division = value;
                          divisionSelected = true;
                          setState(() {});
                        },
                        list: divisions,
                        onSaved: (value) {
                          _division = value;
                          divisionSelected = true;
                          setState(() {});
                        },
                      ),
                      divisionSelected
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'You must choose division.',
                                  style: TextStyle(
                                    color: Theme.of(context).errorColor,
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 21,
                      ),
                      DropDown(
                        needSpace: false,
                        labelText: 'Department',
                        hintText: 'Select department',
                        value: user.department != '' ? user.department : null,
                        onChanged: (value) {
                          _department = value;
                          departmentSelected = true;
                          setState(() {});
                        },
                        list: departments,
                        onSaved: (value) {
                          _department = value;
                          departmentSelected = true;
                          setState(() {});
                        },
                      ),
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
                              'Update User',
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
