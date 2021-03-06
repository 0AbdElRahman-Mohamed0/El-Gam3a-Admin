import 'package:elgam3a_admin/models/faculty_model.dart';
import 'package:elgam3a_admin/models/hall_model.dart';
import 'package:elgam3a_admin/providers/faculities_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/data_added_pop_up.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddHallScreen extends StatefulWidget {
  @override
  _AddHallScreenState createState() => _AddHallScreenState();
}

class _AddHallScreenState extends State<AddHallScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  FacultyModel _faculty;

  int _hallID;
  int _hallCapacity;

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      final hall = HallModel(
        capacity: _hallCapacity,
        id: _hallID,
      );
      await context.read<FacultiesProvider>().addHall(hall, _faculty.id);
      Navigator.pop(context);
      await showDialog(
          context: context,
          builder: (BuildContext context) => DataAddedPopUp());
      Navigator.pop(context);
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
    final faculties = context.watch<FacultiesProvider>().faculties;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Hall',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        DropDown<FacultyModel>(
                          needSpace: false,
                          labelText: 'Faculty',
                          hintText: 'Select faculty',
                          onChanged: (value) {
                            _faculty = value;
                            setState(() {});
                          },
                          list: faculties,
                          onSaved: (value) {
                            _faculty = value;
                          },
                          validator: (v) =>
                              v == null ? 'You must choose faculty.' : null,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        TextDataField(
                          labelName: 'Hall id',
                          hintText: 'Enter hall id',
                          onSaved: (id) {
                            _hallID = num.parse(id);
                          },
                          keyboardType: TextInputType.number,
                          validator: Validator(
                            rules: [
                              RequiredRule(
                                validationMessage: 'Hall id is required.',
                              ),
                            ],
                          ),
                        ),
                        TextDataField(
                          maxLength: 9,
                          labelName: 'Capacity',
                          hintText: 'Enter hall capacity',
                          onSaved: (capacity) {
                            _hallCapacity = num.parse(capacity);
                          },
                          keyboardType: TextInputType.number,
                          validator: Validator(
                            rules: [
                              RequiredRule(
                                validationMessage: 'Hall capacity is required.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _submit,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).buttonColor,
                        ),
                        child: Center(
                          child: Text(
                            'Add Hall',
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
      ),
    );
  }
}
