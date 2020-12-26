// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:promo_hunter_admin/models/brand_model.dart';
// import 'package:promo_hunter_admin/notifier_providers/brand_notifier_provider.dart';
// import 'package:promo_hunter_admin/providers/brands_provider.dart';
// import 'package:promo_hunter_admin/screens/brand_screens/add_brand_screen.dart';
// import 'package:promo_hunter_admin/screens/brand_screens/brand_details_screen.dart';
// import 'package:promo_hunter_admin/utils/loading.dart';
// import 'package:promo_hunter_admin/widgets/search_sheet.dart';
//
// class BrandsScreen extends StatefulWidget {
//   @override
//   _BrandsScreenState createState() => _BrandsScreenState();
// }
//
// class _BrandsScreenState extends State<BrandsScreen> {
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
//   _search() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(4),
//           topRight: Radius.circular(4),
//         ),
//       ),
//       enableDrag: true,
//       isDismissible: true,
//       isScrollControlled: true,
//       builder: (BuildContext context) => SearchSheet(
//         type: 'brand',
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final brands = context.watch<BrandsProvider>().filteredBrands;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Brands',
//           style: Theme.of(context).textTheme.headline3,
//         ),
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Icon(
//             Icons.arrow_back_ios,
//             color: Theme.of(context).appBarTheme.iconTheme.color,
//             size: Theme.of(context).appBarTheme.iconTheme.size,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () => _search(),
//             icon: Icon(
//               Icons.search,
//               color: Theme.of(context).appBarTheme.iconTheme.color,
//               size: Theme.of(context).appBarTheme.iconTheme.size,
//             ),
//           ),
//         ],
//       ),
//       body: brands == null
//           ? Center(
//               child: LoadingWidget(),
//             )
//           : brands.isEmpty
//               ? Center(
//                   child: Text(
//                     'No Brands Found',
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: brands.length,
//                   itemBuilder: (context, int i) =>
//                       ChangeNotifierProvider<BrandNotifierProvider>(
//                     create: (_) => BrandNotifierProvider(brands[i]),
//                     child: BrandCard(),
//                   ),
//                 ),
//       floatingActionButton: FloatingActionButton(
//         child: Center(
//           child: Icon(
//             Icons.add,
//             color: Theme.of(context).backgroundColor,
//           ),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   ChangeNotifierProvider<BrandNotifierProvider>(
//                 create: (_) => BrandNotifierProvider(BrandModel()),
//                 child: AddBrandScreen(),
//               ),
//             ),
//           );
//         },
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//     );
//   }
// }
//
// class BrandCard extends StatefulWidget {
//   @override
//   _BrandCardState createState() => _BrandCardState();
// }
//
// class _BrandCardState extends State<BrandCard> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _getNumberOfProducts();
//   // }
//   //
//   // _getNumberOfProducts() async {
//   //   final brand = context.read<BrandNotifierProvider>().brand;
//   //   await context.read<BrandsProvider>().getNumberOfProductWithBrand(brand);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final brand = context.watch<BrandNotifierProvider>().brand;
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ChangeNotifierProvider<BrandNotifierProvider>(
//             create: (_) => BrandNotifierProvider(brand),
//             child: BrandDetailsScreen(),
//           ),
//         ),
//       ),
//       child: brand.numberOfProducts == null
//           ? Center(
//               child: LoadingWidget(),
//             )
//           : Container(
//               height: 124,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Theme.of(context).shadowColor,
//                     blurRadius: 4,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(5),
//                 color: Theme.of(context).backgroundColor,
//               ),
//               margin: EdgeInsets.all(8),
//               padding: EdgeInsets.all(8),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 116,
//                     height: 116,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: NetworkImage(
//                           '${brand.picture}',
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 9.3,
//                   ),
//                   Expanded(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             brand?.name == null
//                                 ? SizedBox()
//                                 : Text(
//                                     '${brand.name}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline6
//                                         .copyWith(fontSize: 18),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                             brand?.isSponsored == null
//                                 ? SizedBox()
//                                 : Text(
//                                     'Is Sponsored : ${brand.isSponsored ? 'Yes' : 'No'}',
//                                     style:
//                                         Theme.of(context).textTheme.headline1,
//                                   ),
//                           ],
//                         ),
//                         Text(
//                           '${brand.numberOfProducts} Products',
//                           style: Theme.of(context).textTheme.headline2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
