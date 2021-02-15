import 'package:elgam3a_admin/models/faculty_model.dart';
import 'package:elgam3a_admin/models/hall_model.dart';
import 'package:elgam3a_admin/providers/auth_provider.dart';
import 'package:elgam3a_admin/providers/courses_provider.dart';
import 'package:elgam3a_admin/providers/faculities_provider.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/drop_down.dart';
import 'package:elgam3a_admin/widgets/error_pop_up.dart';
import 'package:elgam3a_admin/widgets/successfully_deleted_pop_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';

class DeleteHallScreen extends StatefulWidget {
  @override
  _DeleteHallScreenState createState() => _DeleteHallScreenState();
}

class _DeleteHallScreenState extends State<DeleteHallScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _isLoading = true;
  FacultyModel _faculty;
  HallModel _hall;

  @override
  void initState() {
    super.initState();
    _getFaculties();
  }

  _getFaculties() async {
    try {
      await context.read<FacultiesProvider>().getFaculties();
      _isLoading = false;
      setState(() {});
    } on FirebaseException catch (e) {
      _isLoading = false;
      setState(() {});
      showDialog(
        context: context,
        builder: (BuildContext context) => ErrorPopUp(
            message: 'Something went wrong, please try again \n ${e.message}'),
      );
    } catch (e, s) {
      _isLoading = false;
      setState(() {});
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

  _submit() async {
    if (!_formKey.currentState.validate()) {
      if (!_autoValidate) setState(() => _autoValidate = true);
      return;
    }
    _formKey.currentState.save();
    try {
      LoadingScreen.show(context);
      await context.read<FacultiesProvider>().deleteHall(_hall, _faculty.id);
      Navigator.pop(context);
      await showDialog(
          context: context,
          builder: (BuildContext context) => SuccessfullyDeletedPopUp());
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
      body: _isLoading
          ? Center(
              child: LoadingWidget(),
            )
          : Padding(
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
                        if (_faculty != null) ...{
                          SizedBox(
                            height: 24,
                          ),
                          DropDown<HallModel>(
                            needSpace: false,
                            labelText: 'Hall',
                            hintText: 'Select Hall',
                            onChanged: (value) {},
                            list: _faculty.halls,
                            onSaved: (value) {
                              _hall = value;
                            },
                            validator: (v) =>
                                v == null ? 'You must choose hall.' : null,
                          ),
                        },
                        SizedBox(
                          height: 24,
                        ),
                      ],
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
                            'Delete Hall',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
