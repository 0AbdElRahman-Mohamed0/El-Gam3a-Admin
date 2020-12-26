// import 'package:flutter/material.dart';
// import 'package:promo_hunter_admin/models/product_model.dart';
// import 'package:promo_hunter_admin/notifier_providers/product_notifier_provider.dart';
// import 'package:promo_hunter_admin/providers/products_provider.dart';
// import 'package:promo_hunter_admin/screens/product_screens/add_product_screen.dart';
// import 'package:promo_hunter_admin/screens/product_screens/product_details_screen.dart';
// import 'package:promo_hunter_admin/utils/loading.dart';
// import 'package:promo_hunter_admin/widgets/search_sheet.dart';
//
// class ProductsScreen extends StatefulWidget {
//   @override
//   _ProductsScreenState createState() => _ProductsScreenState();
// }
//
// class _ProductsScreenState extends State<ProductsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _getData();
//   }
//
//   _getData() async {
//     await context.read<ProductsProvider>().getProductsData();
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
//         type: 'product',
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final products = context.watch<ProductsProvider>().filteredProducts;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Products',
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
//       body: products == null
//           ? Center(
//               child: LoadingWidget(),
//             )
//           : products.isEmpty
//               ? Center(
//                   child: Text(
//                     'No Products Found',
//                     style: Theme.of(context).textTheme.headline6,
//                   ),
//                 )
//               : ListView.builder(
//                   itemCount: products.length,
//                   itemBuilder: (context, int i) =>
//                       ChangeNotifierProvider<ProductNotifierProvider>(
//                     create: (_) => ProductNotifierProvider(products[i]),
//                     child: ProductCard(),
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
//                   ChangeNotifierProvider<ProductNotifierProvider>(
//                 create: (_) => ProductNotifierProvider(ProductModel()),
//                 child: AddProductScreen(),
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
// class ProductCard extends StatefulWidget {
//   @override
//   _ProductCardState createState() => _ProductCardState();
// }
//
// class _ProductCardState extends State<ProductCard> {
//   // _getBrand() async {
//   //   try {
//   //     await context.read<ProductNotifierProvider>().getBrand();
//   //   } catch (e, s) {
//   //     print(s);
//   //     print(e);
//   //   }
//   // }
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _getBrand();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final product = context.watch<ProductNotifierProvider>().product;
//
//     print(product.brandModel?.name);
//     return product.brandModel == null
//         ? Center(
//             child: LoadingWidget(),
//           )
//         : GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       ChangeNotifierProvider<ProductNotifierProvider>(
//                     create: (_) => ProductNotifierProvider(product),
//                     child: ProductDetailsScreen(),
//                   ),
//                 ),
//               );
//             },
//             child: Container(
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
//                           '${product.picture}',
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 9.3,
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             product?.brandModel?.name == null
//                                 ? SizedBox()
//                                 : Text(
//                                     product.brandModel.name,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline6
//                                         .copyWith(fontSize: 18),
//                                   ),
//                             Text(
//                               "${product.name}",
//                               style: Theme.of(context).textTheme.headline1,
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             product?.brandModel?.name == null
//                                 ? SizedBox()
//                                 : Text(
//                                     product.brandModel.name,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline2
//                                         .copyWith(fontSize: 16),
//                                   ),
//                             product.weight == null
//                                 ? SizedBox()
//                                 : Text(
//                                     product.weight.toString(),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .headline2
//                                         .copyWith(fontSize: 16),
//                                   ),
//                             Text(
//                               'Rs. ${product.minPrice} (RRP Rs. ${product.basicPrice})',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline2
//                                   .copyWith(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }
