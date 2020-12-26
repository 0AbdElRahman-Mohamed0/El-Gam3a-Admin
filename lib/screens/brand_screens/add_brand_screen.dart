// import 'dart:io' as Io;
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flrx_validator/flrx_validator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;
// import 'package:promo_hunter_admin/models/brand_model.dart';
// import 'package:promo_hunter_admin/notifier_providers/brand_notifier_provider.dart';
// import 'package:promo_hunter_admin/providers/brands_provider.dart';
// import 'package:promo_hunter_admin/providers/uom_provider.dart';
// import 'package:promo_hunter_admin/screens/brand_screens/brands_screen.dart';
// import 'package:promo_hunter_admin/utils/loading.dart';
// import 'package:promo_hunter_admin/widgets/text_data_field.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// class AddBrandScreen extends StatefulWidget {
//   @override
//   _AddBrandScreenState createState() => _AddBrandScreenState();
// }
//
// class _AddBrandScreenState extends State<AddBrandScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//   bool picked = false;
//   Io.File _image;
//   String _uploadedFileURL;
//
//   bool _isSponsored = false;
//   String _name;
//
//   ///////// pick image //////////
//   Future<void> _pickImage() async {
//     final pFile = await ImagePicker().getImage(source: ImageSource.gallery);
//     if (pFile != null) _image = Io.File(pFile.path);
//     if (_image != null) {
//       picked = true;
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   Future<void> _takeImage() async {
//     final pFile = await ImagePicker().getImage(source: ImageSource.camera);
//     if (pFile != null) _image = Io.File(pFile.path);
//     if (_image != null) {
//       picked = true;
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   String get _imagesFolderPath => "Brands"
//       "/${Path.basename(_image.path)}";
//
//   Future<void> uploadImage() async {
//     try {
//       Reference ref = FirebaseStorage.instance.ref().child(_imagesFolderPath);
//       await ref.putFile(_image);
//       await ref.getDownloadURL().then((fileURL) {
//         _uploadedFileURL = fileURL;
//         if (mounted) setState(() {});
//       });
//     } on FirebaseException catch (e) {
//       Alert(
//         context: context,
//         title: 'Couldn\'t Upload your image.',
//         desc: e.message,
//         closeIcon: Icon(
//           Icons.close,
//           color: Theme.of(context)
//               .inputDecorationTheme
//               .enabledBorder
//               .borderSide
//               .color,
//           size: Theme.of(context).iconTheme.size,
//         ),
//         style: AlertStyle(
//           titleStyle:
//               Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
//           descStyle: Theme.of(context).textTheme.headline5,
//         ),
//         buttons: [
//           DialogButton(
//             onPressed: () => Navigator.pop(context),
//             color: Theme.of(context).primaryColor,
//             child: Text(
//               'OK',
//               style: Theme.of(context).textTheme.headline3,
//             ),
//           ),
//         ],
//       ).show();
//     } catch (e) {
//       Alert(
//         context: context,
//         title: 'Couldn\'t Upload your image, Please try again.',
//         closeIcon: Icon(
//           Icons.close,
//           color: Theme.of(context)
//               .inputDecorationTheme
//               .enabledBorder
//               .borderSide
//               .color,
//           size: Theme.of(context).iconTheme.size,
//         ),
//         style: AlertStyle(
//           titleStyle:
//               Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
//         ),
//         buttons: [
//           DialogButton(
//             onPressed: () => Navigator.pop(context),
//             color: Theme.of(context).primaryColor,
//             child: Text(
//               'OK',
//               style: Theme.of(context).textTheme.headline3,
//             ),
//           ),
//         ],
//       ).show();
//
//       print(e);
//     }
//   }
//   ////////////////////////////
//
//   _submit() async {
//     BrandModel brandDetails = context.read<BrandNotifierProvider>().brand;
//     if (!_formKey.currentState.validate()) {
//       setState(() => _autoValidate = true);
//       return;
//     }
//     _formKey.currentState.save();
//     try {
//       LoadingScreen.show(context);
//       if (_image == null) {
//         Navigator.of(context).pop();
//         Alert(
//           context: context,
//           title: 'Image is required.',
//           closeIcon: Icon(
//             Icons.close,
//             color: Theme.of(context)
//                 .inputDecorationTheme
//                 .enabledBorder
//                 .borderSide
//                 .color,
//             size: Theme.of(context).iconTheme.size,
//           ),
//           style: AlertStyle(
//             titleStyle:
//                 Theme.of(context).textTheme.headline6.copyWith(fontSize: 22),
//           ),
//           buttons: [
//             DialogButton(
//               onPressed: () => Navigator.pop(context),
//               color: Theme.of(context).primaryColor,
//               child: Text(
//                 'OK',
//                 style: Theme.of(context).textTheme.headline3,
//               ),
//             ),
//           ],
//         ).show();
//         return;
//       }
//       if (_image != null) {
//         await uploadImage();
//         brandDetails.picture = _uploadedFileURL;
//         brandDetails.imagePath = _imagesFolderPath;
//       }
//       brandDetails.name = _name;
//       brandDetails.isSponsored = _isSponsored;
//       await context.read<BrandNotifierProvider>().addBrand(brandDetails);
//
//       context.read<BrandsProvider>().addBrand(brandDetails);
//
//       Navigator.pop(context);
//       Navigator.pop(context);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BrandsScreen(),
//         ),
//       );
//     } catch (e, s) {
//       Navigator.of(context).pop();
//       print(e);
//       print(s);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 8.8, vertical: 5),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Add Brand',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6
//                         .copyWith(fontSize: 20),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: Icon(
//                       Icons.close,
//                       color: Theme.of(context)
//                           .inputDecorationTheme
//                           .enabledBorder
//                           .borderSide
//                           .color,
//                       size: Theme.of(context).iconTheme.size,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     width: 80.41,
//                     height: 80.41,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(3.04),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: _image == null
//                             ? AssetImage(
//                                 'assets/images/image10230-3-3-4-7-8-0-5-4-0-2-2.png',
//                               )
//                             : FileImage(_image),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 33.9,
//                   ),
//                   GestureDetector(
//                     onTap: () => _pickImage(),
//                     child: Column(
//                       children: [
//                         SvgPicture.asset('assets/svg/upload.svg'),
//                         SizedBox(
//                           height: 9.5,
//                         ),
//                         Text(
//                           'Upload',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline2
//                               .copyWith(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20.2,
//                   ),
//                   GestureDetector(
//                     onTap: () => _takeImage(),
//                     child: Column(
//                       children: [
//                         SvgPicture.asset('assets/svg/camera.svg'),
//                         SizedBox(
//                           height: 9.5,
//                         ),
//                         Text(
//                           'Camera',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline2
//                               .copyWith(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 26,
//               ),
//               Form(
//                 key: _formKey,
//                 autovalidateMode: _autoValidate
//                     ? AutovalidateMode.always
//                     : AutovalidateMode.disabled,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 2.7),
//                   child: Column(
//                     children: [
//                       TextDataField(
//                         labelName: 'Brand Name',
//                         hintText: 'Enter Brand Name',
//                         onSaved: (name) {
//                           _name = name;
//                         },
//                         validator: Validator(
//                           rules: [
//                             RequiredRule(
//                               validationMessage: 'Name is required.',
//                             ),
//                             MinLengthRule(
//                               3,
//                               validationMessage:
//                                   'Name should have at least 3 characters.',
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                             activeColor: Theme.of(context).primaryColor,
//                             checkColor: Colors.white,
//                             value: _isSponsored,
//                             onChanged: (value) {
//                               setState(() {
//                                 _isSponsored = value;
//                               });
//                             },
//                           ),
//                           Text(
//                             'isSponsored',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline2
//                                 .copyWith(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 32),
//                       GestureDetector(
//                         onTap: () => _submit(),
//                         child: Container(
//                           width: double.infinity,
//                           height: 48,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: Theme.of(context).primaryColor,
//                           ),
//                           child: Center(
//                             child: Text(
//                               'FINISH',
//                               style: Theme.of(context).textTheme.headline3,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 32),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
