// import 'dart:io' as Io;
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flrx_validator/flrx_validator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as Path;
// import 'package:promo_hunter_admin/models/brand_model.dart';
// import 'package:promo_hunter_admin/models/product_model.dart';
// import 'package:promo_hunter_admin/models/uom_model.dart';
// import 'package:promo_hunter_admin/notifier_providers/product_notifier_provider.dart';
// import 'package:promo_hunter_admin/providers/brands_provider.dart';
// import 'package:promo_hunter_admin/providers/products_provider.dart';
// import 'package:promo_hunter_admin/providers/uom_provider.dart';
// import 'package:promo_hunter_admin/screens/product_screens/products_screen.dart';
// import 'package:promo_hunter_admin/utils/loading.dart';
// import 'package:promo_hunter_admin/widgets/drop_down.dart';
// import 'package:promo_hunter_admin/widgets/text_data_field.dart';
// import 'package:quiver/strings.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
//
// class AddProductScreen extends StatefulWidget {
//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }
//
// class _AddProductScreenState extends State<AddProductScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _barcodeController = TextEditingController();
//   bool _autoValidate = false;
//   bool picked = false;
//   Io.File _image;
//   String _uploadedFileURL;
//
//   bool _isLocal = false;
//   String _name;
//   num _price;
//   String _measure;
//   String _barcode;
//   BrandModel _newBrand;
//   UomModel _newUom;
//
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }
//
//   _getData() async {
//     await context.read<BrandsProvider>().getBrandsData();
//     await context.read<UomsProvider>().getUomsData();
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
//   String get _imagesFolderPath => "Product Images"
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
//     ProductModel productDetails =
//         context.read<ProductNotifierProvider>().product;
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
//         productDetails.picture = _uploadedFileURL;
//         productDetails.imagePath = _imagesFolderPath;
//       }
//       productDetails.brandId = _newBrand.id;
//       productDetails.name = _name;
//       productDetails.basicPrice = _price;
//       print('_measure');
//       print(_measure);
//       productDetails.measure = _measure.isEmpty ? 0 : int.parse(_measure);
//       productDetails.barcode = _barcode;
//       productDetails.isLocal = _isLocal;
//       productDetails.uom = _newUom?.name;
//       // setState(() {});
//       await context.read<ProductNotifierProvider>().addProduct(productDetails);
//
//       context.read<ProductsProvider>().addProduct(productDetails);
//
//       Navigator.pop(context);
//       Navigator.pop(context);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductsScreen(),
//         ),
//       );
//     } catch (e, s) {
//       Navigator.of(context).pop();
//       print(e);
//       print(s);
//     }
//   }
//
//   _scanQr() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.QR);
//
//     if (barcodeScanRes == null || barcodeScanRes == '-1') return;
//
//     _barcode = barcodeScanRes;
//
//     _barcodeController.text = barcodeScanRes;
//
//     if (mounted) setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final brands = context.watch<BrandsProvider>().brands;
//     brands?.sort((a, b) => a.name.compareTo(b.name));
//     final uoms = context.watch<UomsProvider>().uoms;
//     uoms?.sort((a, b) => a.name.compareTo(b.name));
//
//     return SafeArea(
//       child: Scaffold(
//         body: brands == null || uoms == null
//             ? Center(
//                 child: LoadingWidget(),
//               )
//             : SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 8.8, vertical: 5),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Add Product',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline6
//                               .copyWith(fontSize: 20),
//                         ),
//                         IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: Icon(
//                             Icons.close,
//                             color: Theme.of(context)
//                                 .inputDecorationTheme
//                                 .enabledBorder
//                                 .borderSide
//                                 .color,
//                             size: Theme.of(context).iconTheme.size,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           width: 80.41,
//                           height: 80.41,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(3.04),
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               image: _image == null
//                                   ? AssetImage(
//                                       'assets/images/image10230-3-3-4-7-8-0-5-4-0-2-2.png',
//                                     )
//                                   : FileImage(_image),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 33.9,
//                         ),
//                         GestureDetector(
//                           onTap: () => _pickImage(),
//                           child: Column(
//                             children: [
//                               SvgPicture.asset('assets/svg/upload.svg'),
//                               SizedBox(
//                                 height: 9.5,
//                               ),
//                               Text(
//                                 'Upload',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline2
//                                     .copyWith(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20.2,
//                         ),
//                         GestureDetector(
//                           onTap: () => _takeImage(),
//                           child: Column(
//                             children: [
//                               SvgPicture.asset('assets/svg/camera.svg'),
//                               SizedBox(
//                                 height: 9.5,
//                               ),
//                               Text(
//                                 'Camera',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .headline2
//                                     .copyWith(fontSize: 16),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 26,
//                     ),
//                     Form(
//                       key: _formKey,
//                       autovalidateMode: _autoValidate
//                           ? AutovalidateMode.always
//                           : AutovalidateMode.disabled,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.7),
//                         child: Column(
//                           children: [
//                             DropDown<BrandModel>(
//                               value: _newBrand,
//                               onChanged: (value) {
//                                 _newBrand = value;
//                                 setState(() {});
//                               },
//                               hintText: 'Select Brand',
//                               labelText: 'Brand',
//                               list: brands,
//                               validator: (_) =>
//                                   _ != null ? null : 'Brand is required',
//                               onSaved: (value) {
//                                 _newBrand = value;
//                                 setState(() {});
//                               },
//                             ),
//                             TextDataField(
//                               labelName: 'Name',
//                               hintText: 'Enter Name',
//                               onSaved: (name) {
//                                 _name = name;
//                               },
//                               validator: Validator(
//                                 rules: [
//                                   RequiredRule(
//                                     validationMessage: 'Name is required.',
//                                   ),
//                                   MinLengthRule(
//                                     3,
//                                     validationMessage:
//                                         'Name should have at least 3 characters.',
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             TextDataField(
//                               labelName: 'Price',
//                               hintText: 'Enter Price',
//                               keyboardType: TextInputType.number,
//                               inputFormatters: [],
//                               onSaved: (p) {
//                                 _price = num.tryParse(p);
//                               },
//                               validator: Validator(
//                                 rules: [
//                                   RequiredRule(
//                                     validationMessage: 'Price is required.',
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             DropDown<UomModel>(
//                               labelText: 'Uom',
//                               hintText: 'Select Uom',
//                               onChanged: (value) {
//                                 _newUom = value;
//                                 setState(() {});
//                               },
//                               validator: null,
//                               list: uoms,
//                               onSaved: (value) {
//                                 _newUom = value;
//                                 setState(() {});
//                               },
//                             ),
//                             TextDataField(
//                               keyboardType: TextInputType.number,
//                               labelName: 'Measure',
//                               hintText: 'Enter Measure',
//                               onSaved: (measure) {
//                                 _measure = measure;
//                               },
//                             ),
//                             TextDataField(
//                               controller: _barcodeController,
//                               keyboardType: TextInputType.number,
//                               labelName: 'Barcode',
//                               hintText: 'Enter Barcode',
//                               onSaved: (barcode) {
//                                 if (barcode != null || !isBlank(barcode))
//                                   _barcode = barcode;
//                               },
//                               validator: Validator(
//                                 rules: [
//                                   RequiredRule(
//                                     validationMessage: 'Barcode is required.',
//                                   ),
//                                   MinLengthRule(
//                                     3,
//                                     validationMessage:
//                                         'Barcode should have at least 3 characters.',
//                                   ),
//                                 ],
//                               ),
//                               suffixIcon: GestureDetector(
//                                 onTap: () => _scanQr(),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                     'assets/icons/badge.png',
//                                     height: 24.0,
//                                     width: 24.0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Checkbox(
//                                   activeColor: Theme.of(context).primaryColor,
//                                   checkColor: Colors.white,
//                                   value: _isLocal,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _isLocal = value;
//                                     });
//                                   },
//                                 ),
//                                 Text(
//                                   'isLocal',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline2
//                                       .copyWith(fontSize: 16),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 32),
//                             GestureDetector(
//                               onTap: () => _submit(),
//                               child: Container(
//                                 width: double.infinity,
//                                 height: 48,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'FINISH',
//                                     style:
//                                         Theme.of(context).textTheme.headline3,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 32),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }
