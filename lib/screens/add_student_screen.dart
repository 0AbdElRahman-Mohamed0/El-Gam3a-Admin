import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/providers/users_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _name;
  String _univID;
  String _phoneNumber;
  String _email;
  String _division;

  bool divisionSelected = true;

  List<String> divisions = [
    'Natural Science',
    'Biology',
    'Geology',
  ];

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (_division == null) divisionSelected = false;
      setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      final user = UserModel(
        name: _name,
        type: 'Student',
        phoneNumber: _phoneNumber,
        email: _email,
        division: _division,
        univID: _univID,
      );
      final pass = context.read<UsersProvider>().getRandomPassword();
      //TODO: put generated pass instead of 111111
      await context.read<UsersProvider>().addNewStudent(user, '111111');
      Navigator.pop(context);
      Alert(
        context: context,
        title: 'User added',
        desc: 'Email : $_email\nPassword : $pass',
        style: AlertStyle(
          titleStyle: Theme.of(context).textTheme.headline6,
          descStyle: Theme.of(context).textTheme.headline1,
        ),
      ).show();
      _formKey.currentState.reset();
    } catch (e, s) {
      Navigator.pop(context);
      print(e);
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            'Name should have at least 9 characters.',
                      ),
                    ],
                  ),
                ),
                TextDataField(
                  labelName: 'Phone number',
                  hintText: 'Enter Phone Number',
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
                  onSaved: (email) {
                    _email = email;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(validationMessage: 'Email is required.'),
                    ],
                  ),
                ),
                TextDataField(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  labelName: 'Student ID',
                  hintText: 'Enter Student ID',
                  onSaved: (univID) {
                    _univID = univID;
                  },
                  validator: Validator(
                    rules: [
                      RequiredRule(
                          validationMessage: 'Student ID is required.'),
                      MinLengthRule(11,
                          validationMessage: 'Student ID should be 11 number.'),
                    ],
                  ),
                ),
                DropDown(
                  needSpace: false,
                  labelText: 'Division',
                  hintText: 'Select division',
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
                        'Add Student',
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
