import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/successfully_update_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _phoneNumber;
  String _division;
  String _department;
  String _minor;
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
    UserModel user = context.read<UsersProvider>().user;

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
        completedHours: _completedHours,
        gpa: _cgpa,
        registeredHours: _registeredHours,
        division: _division,
        department: _department,
        minor: _minor,
      );
      await context.read<UsersProvider>().updateUser(user);
      Navigator.pop(context);
      await showDialog(
          context: context,
          builder: (BuildContext context) => SuccessfullyUpdatePopUp());
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
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
    final user = context.watch<UsersProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update User',
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
                            'Name should have at least 3 characters.',
                      ),
                    ],
                  ),
                ),
                TextDataField(
                  labelName: 'Phone number',
                  hintText: 'Enter Phone Number',
                  initialValue: user.phoneNumber,
                  maxLength: 11,
                  keyboardType: TextInputType.number,
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
                          validationMessage: 'Completed hours is required.'),
                    ],
                  ),
                ),
                if (user.type == 'Student') ...{
                  TextDataField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp("[A-Za-z~`!@\$'#%=+^&*()\"_-]"))
                    ],
                    keyboardType: TextInputType.number,
                    labelName: 'CGPA',
                    hintText: 'Enter CGPA',
                    initialValue: user.gpa,
                    onSaved: (cgpa) {
                      _cgpa = cgpa;
                    },
                    validator: Validator(
                      rules: [
                        RequiredRule(validationMessage: 'CGPA is required.'),
                      ],
                    ),
                  ),
                },
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
                          validationMessage: 'Registered hours is required.'),
                    ],
                  ),
                ),
                if (user.type == 'Student') ...{
                  DropDown(
                    needSpace: false,
                    labelText: 'Division',
                    hintText: 'Select division',
                    list: divisions,
                    value: user.division ?? _division,
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
                SizedBox(
                  height: 21,
                ),
                DropDown(
                  needSpace: false,
                  labelText: 'Department',
                  hintText: 'Select department',
                  value: user.department ?? _department,
                  list: departments,
                  onChanged: (department) {
                    _department = department;
                    setState(() {});
                  },
                  onSaved: (department) {
                    _department = department;
                  },
                  validator: (String v) =>
                      v == null ? 'You must choose department.' : null,
                ),
                if (user.type == 'Student') ...{
                  DropDown(
                    needSpace: false,
                    labelText: 'Minor',
                    hintText: 'Select minor',
                    value: user.minor ?? _minor,
                    list: departments,
                    onChanged: (department) {
                      _minor = department;
                      setState(() {});
                    },
                    onSaved: (department) {
                      _minor = department;
                    },
                    validator: (String v) =>
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
