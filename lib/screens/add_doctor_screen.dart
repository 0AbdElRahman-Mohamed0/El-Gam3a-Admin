// import 'package:elgam3a_admin/widgets/text_data_field.dart';
// import 'package:flrx_validator/flrx_validator.dart';
// import 'package:flutter/material.dart';
//
// class AddDoctorScreen extends StatefulWidget {
//   @override
//   _AddDoctorScreenState createState() => _AddDoctorScreenState();
// }
//
// class _AddDoctorScreenState extends State<AddDoctorScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   bool _autoValidate = false;
//
//   String _name;
//
//   String _phoneNumber;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add New User',
//           style: Theme.of(context).textTheme.headline3,
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//         child: Form(
//           key: _formKey,
//           autovalidateMode: _autoValidate
//               ? AutovalidateMode.always
//               : AutovalidateMode.disabled,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 2.7),
//             child: Column(
//               children: [
//                 TextDataField(
//                   labelName: 'Name',
//                   hintText: 'Enter Name',
//                   onSaved: (name) {
//                     _name = name;
//                   },
//                   validator: Validator(
//                     rules: [
//                       RequiredRule(
//                         validationMessage: 'Name is required.',
//                       ),
//                       MinLengthRule(
//                         3,
//                         validationMessage:
//                         'Name should have at least 9 characters.',
//                       ),
//                     ],
//                   ),
//                 ),
//                 TextDataField(
//                   labelName: 'Phone number',
//                   hintText: 'Enter Phone Number',
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [],
//                   onSaved: (phoneNumber) {
//                     _phoneNumber = phoneNumber;
//                   },
//                   validator: Validator(
//                     rules: [
//                       RequiredRule(
//                         validationMessage: 'Phone number is required.',
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(Icons.perso),
//                 DropDown<UomModel>(
//                   labelText: 'Uom',
//                   hintText: 'Select Uom',
//                   onChanged: (value) {
//                     _newUom = value;
//                     setState(() {});
//                   },
//                   validator: null,
//                   list: uoms,
//                   onSaved: (value) {
//                     _newUom = value;
//                     setState(() {});
//                   },
//                 ),
//                 TextDataField(
//                   keyboardType: TextInputType.number,
//                   labelName: 'Measure',
//                   hintText: 'Enter Measure',
//                   onSaved: (measure) {
//                     _measure = measure;
//                   },
//                 ),
//                 TextDataField(
//                   controller: _barcodeController,
//                   keyboardType: TextInputType.number,
//                   labelName: 'Barcode',
//                   hintText: 'Enter Barcode',
//                   onSaved: (barcode) {
//                     if (barcode != null || !isBlank(barcode))
//                       _barcode = barcode;
//                   },
//                   validator: Validator(
//                     rules: [
//                       RequiredRule(
//                         validationMessage: 'Barcode is required.',
//                       ),
//                       MinLengthRule(
//                         3,
//                         validationMessage:
//                         'Barcode should have at least 3 characters.',
//                       ),
//                     ],
//                   ),
//                   suffixIcon: GestureDetector(
//                     onTap: () => _scanQr(),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.asset(
//                         'assets/icons/badge.png',
//                         height: 24.0,
//                         width: 24.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Checkbox(
//                       activeColor: Theme.of(context).primaryColor,
//                       checkColor: Colors.white,
//                       value: _isLocal,
//                       onChanged: (value) {
//                         setState(() {
//                           _isLocal = value;
//                         });
//                       },
//                     ),
//                     Text(
//                       'isLocal',
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline2
//                           .copyWith(fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 32),
//                 GestureDetector(
//                   onTap: () => _submit(),
//                   child: Container(
//                     width: double.infinity,
//                     height: 48,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Theme.of(context).primaryColor,
//                     ),
//                     child: Center(
//                       child: Text(
//                         'FINISH',
//                         style: Theme.of(context).textTheme.headline3,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
