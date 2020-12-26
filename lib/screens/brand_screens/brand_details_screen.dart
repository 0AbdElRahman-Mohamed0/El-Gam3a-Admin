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
// import 'package:promo_hunter_admin/utils/loading.dart';
// import 'package:promo_hunter_admin/widgets/text_data_field.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// class BrandDetailsScreen extends StatefulWidget {
//   @override
//   _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
// }
//
// class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//   bool picked = false;
//   Io.File _image;
//   String _uploadedFileURL;
//
//   String _name;
//
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }
//
//   _getData() async {
//     await context.read<BrandsProvider>().getBrandsData();
//   }
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
//       "/${Path.basename(_image?.path)}";
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
//
//   ////////////////////////////
//
//   _update() async {
//     if (!_formKey.currentState.validate()) {
//       setState(() => _autoValidate = true);
//       return;
//     }
//
//     _formKey.currentState.save();
//
//     try {
//       BrandModel brandDetails = context.read<BrandNotifierProvider>().brand;
//
//       LoadingScreen.show(context);
//
//       if (_image != null) {
//         await context
//             .read<BrandNotifierProvider>()
//             .deleteImage(brandDetails.imagePath);
//         await uploadImage();
//         brandDetails.picture = _uploadedFileURL;
//         brandDetails.imagePath = _imagesFolderPath;
//       }
//       brandDetails.name = _name;
//
//       await context.read<BrandNotifierProvider>().updateBrandData(brandDetails);
//       context.read<BrandNotifierProvider>().updateBrandModel();
//       context.read<BrandsProvider>().resetValues();
//
//       Navigator.pop(context);
//       Navigator.pop(context);
//     } catch (e, s) {
//       Navigator.pop(context);
//       print(e);
//       print(s);
//     }
//   }
//
//   _deleteBrand() async {
//     BrandModel brandDetails = context.read<BrandNotifierProvider>().brand;
//     try {
//       LoadingScreen.show(context);
//       await context.read<BrandNotifierProvider>().deleteBrand(brandDetails.id);
//       context.read<BrandsProvider>().deleteBrand(brandDetails);
//       await context
//           .read<BrandNotifierProvider>()
//           .deleteImage(brandDetails.imagePath);
//
//       Navigator.pop(context);
//       Navigator.pop(context);
//     } catch (e, s) {
//       Navigator.pop(context);
//       print(e);
//       print(s);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final brand = context.watch<BrandNotifierProvider>().brand;
//
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
//                     'View / Edit Brand',
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
//                             ? brand?.picture == null
//                                 ? AssetImage(
//                                     'assets/images/image10230-3-3-4-7-8-0-5-4-0-2-2.png',
//                                   )
//                                 : NetworkImage('${brand.picture}')
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
//               SizedBox(height: 26),
//               Form(
//                 key: _formKey,
//                 autovalidateMode: _autoValidate
//                     ? AutovalidateMode.always
//                     : AutovalidateMode.disabled,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 2.7),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextDataField(
//                         initialValue: brand?.name,
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
//                             value: brand?.isSponsored ?? false,
//                             onChanged: (value) {
//                               setState(() {
//                                 brand?.isSponsored = value;
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
//                       SizedBox(height: 16),
//                       Text(
//                         '${brand?.numberOfProducts} Products in App',
//                         style: Theme.of(context).textTheme.headline2,
//                       ),
//                       SizedBox(height: 32),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () => _deleteBrand(),
//                             child: Container(
//                               height: 48,
//                               padding: EdgeInsets.symmetric(horizontal: 16),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.red,
//                               ),
//                               child: Center(
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.delete_outline),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Delete',
//                                       style:
//                                           Theme.of(context).textTheme.headline4,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 33.0),
//                 child: GestureDetector(
//                   onTap: () => _update(),
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
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
