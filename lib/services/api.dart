import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/models/department_model.dart';
import 'package:elgam3a_admin/models/faculty_model.dart';
import 'package:elgam3a_admin/models/hall_model.dart';
import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/services/vars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ApiProvider {
  ApiProvider._();
  static final ApiProvider instance = ApiProvider._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  UserModel user;
  CourseModel course;

//////////////////////////////////Auth////////////////////
  // SignIn
  Future<void> signInUsingEmailAndPassword(
      String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  ////

  Future<void> addNewUser(UserModel user, String pass) async {
    await auth.createUserWithEmailAndPassword(
      email: user.email,
      password: pass,
    );

    await firestore
        .collection(UserData.USER_DATA_TABLE)
        .doc(auth.currentUser.uid)
        .set(user.toMap());

    await firestore
        .collection(UserData.USER_DATA_TABLE)
        .doc(auth.currentUser.uid)
        .update({UserData.ID: auth.currentUser.uid});
  }

  /////// Add Course //////////////////////////////////////////////

  //TODO : old one
  // Future<void> addCourse(CourseModel course) async {
  //   final DocumentReference data =
  //       await firestore.collection(CourseData.COURSE_TABLE).add(course.toMap());
  //
  //   await firestore
  //       .collection(CourseData.COURSE_TABLE)
  //       .doc(data.id)
  //       .update({CourseData.ID: data.id});
  // }

  //TODO : new one of courses add , delete and update
  Future<void> updateCourse(
      List<CourseModel> courses, String departmentID) async {
    await firestore
        .collection(DepartmentData.DEPARTMENT_TABLE)
        .doc(departmentID)
        .update({
      DepartmentData.COURSES: courses.map((course) => course.toMap()).toList(),
    });
  }

  ///////////// DELETE USER //////////////////////////
  Future<void> deleteUser(String univID) async {
    await firestore
        .collection(UserData.USER_DATA_TABLE)
        .where(UserData.UNIV_ID, isEqualTo: univID)
        .get()
        .then((value) async {
      final db = firestore.batch();

      for (final i in value.docs) {
        db.delete(i.reference);
      }

      await db.commit();
    });
  }

  // Get Data
  Future<UserModel> getDataOfStudentByUnivID(String univID) async {
    final _response = await firestore
        .collection(UserData.USER_DATA_TABLE)
        .where(UserData.UNIV_ID, isEqualTo: univID)
        .get();
    if (_response.docs.isNotEmpty) {
      user = UserModel.fromMap(_response.docs.first.data());
      return user;
    } else {
      print('api Error@getDataOfStudentByUnivID');
      // Err
      return user;
    }
  }

  Future<void> deleteFireBaseStorageImage(String filePath) async {
    print('start');
    await FirebaseStorage.instance.ref().child(filePath).delete().whenComplete(
        () => print('Successfully deleted $filePath storage item'));
    print('done');
  }

  //////////////////////GET COURSE BY CODE/////////////////////////////
  Future<CourseModel> getCourseByCode(String courseCode) async {
    final _response = await firestore
        .collection(CourseData.COURSE_TABLE)
        .where(CourseData.CODE, isEqualTo: courseCode)
        .get();
    if (_response.docs.isNotEmpty) {
      course = CourseModel.fromMap(_response.docs.first.data());
      return course;
    } else {
      print('api Error@getCourseByCode');
      // Err
      return course;
    }
  }

  ///////////// DELETE COURSE //////////////////////////
  // Future<void> deleteCourse(String courseCode) async {
  //   await firestore
  //       .collection(CourseData.COURSE_TABLE)
  //       .where(CourseData.CODE, isEqualTo: courseCode)
  //       .get()
  //       .then((value) async {
  //     final db = firestore.batch();
  //
  //     for (final i in value.docs) {
  //       db.delete(i.reference);
  //     }
  //
  //     await db.commit();
  //   });
  // }

//////////// Update USER //////////////////
  Future<void> updateUser(UserModel user) async {
    await firestore
        .collection(UserData.USER_DATA_TABLE)
        .doc(user.userID)
        .update(user.toMap());
  }

  // Future<void> updateCourse(CourseModel course) async {
  //   await firestore
  //       .collection(CourseData.COURSE_TABLE)
  //       .doc(course.courseID)
  //       .update(course.toMap());
  // }

  Future<List<FacultyModel>> getFaculties() async {
    final _response =
        await firestore.collection(FacultyData.FACULTY_TABLE).get();
    if (_response.docs.isNotEmpty) {
      final List<FacultyModel> _faculties = [];
      _response.docs.forEach((element) {
        _faculties.add(FacultyModel.fromMap(element.data()));
      });
      return _faculties;
    } else {
      print('api Error@getFaculties');
      // Err
      throw _response.docs;
    }
  }

  Future<void> updateHall(List<HallModel> halls, String facultyID) async {
    await firestore
        .collection(FacultyData.FACULTY_TABLE)
        .doc(facultyID)
        .update({
      FacultyData.HALLS: halls.map((hall) => hall.toMap()).toList(),
    });
  }

  Future<List<DepartmentModel>> getDepartments() async {
    final _response =
        await firestore.collection(DepartmentData.DEPARTMENT_TABLE).get();
    if (_response.docs.isNotEmpty) {
      final List<DepartmentModel> _departments = [];
      _response.docs.forEach((department) {
        _departments.add(DepartmentModel.fromMap(department.data()));
      });
      return _departments;
    } else {
      print('api Error@getDepartments');
      // Err
      throw _response.docs;
    }
  }

//   //////////////FORGET PASSWORD//////////////////////////////////////
//
//   Future<void> forgetPassword(String email) async {
//     await auth.sendPasswordResetEmail(email: email);
//   }
//
//   ///////////////////GET Farmer BY ID///////////////////////////
//
//   Future<UserModel> getFarmerByID(String farmerID) async {
//     final _response = await firestore
//         .collection(UserData.USER_DATA_TABLE)
//         .get()
//         .then((QuerySnapshot value) =>
//             value.docs.firstWhere((element) => element['userID'] == farmerID));
//     UserModel _l;
//     if (_response.exists) {
//       _l = UserModel.fromMap(_response.data());
//       return _l;
//     } else {
//       print('api Error@getFarmerByID');
//       // Err
//       throw _l;
//     }
//   }
//
// //////////////////////////////////Products////////////////////
//   Future<List<ProductModel>> getProductsData(String type) async {
//     final _response = await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .where(ProductCollection.TYPE, isEqualTo: type)
//         .where(ProductCollection.POUNDS, isGreaterThan: 0)
//         .get();
//     final _l = <ProductModel>[];
//     if (_response.docs.isNotEmpty) {
//       _response.docs.forEach((element) {
//         _l.add(ProductModel.fromMap(element.data()));
//       });
//
//       return _l;
//     } else {
//       print('api Error@getProductsData');
//       // Err
//       return _l;
//     }
//   }
//
//   Future<List<ProductModel>> getProductsDataByFarmerId(
//       String type, String uid) async {
//     final _response = await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .where(ProductCollection.TYPE, isEqualTo: type)
//         .where(ProductCollection.FARMER_ID, isEqualTo: uid)
//         .where(ProductCollection.POUNDS, isGreaterThan: 0)
//         .get();
//
//     // .then((QuerySnapshot value) => value.docs.where((element) =>
//     //     element[ProductCollection.TYPE] == type &&
//     //     element[ProductCollection.FARMER_ID] == uid));
//     final _l = <ProductModel>[];
//     if (_response.docs.isNotEmpty) {
//       _response.docs.forEach((element) {
//         _l.add(ProductModel.fromMap(element.data()));
//       });
//
//       return _l;
//     } else {
//       print('api Error@getProductsDataByFarmerId');
//       // Err
//       return _l;
//     }
//   }
//
//   Future<ProductModel> addProduct(ProductModel product) async {
//     final DocumentReference data = await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .add(product.toMap());
//
//     await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .doc(data.id)
//         .update({ProductCollection.ID: data.id});
//     return data.get().then((value) => ProductModel.fromMap(value.data()));
//   }
//
//   ///////////////////GET PRODUCT BY ID///////////////////////////
//
//   Future<ProductModel> getProductByID(String productID) async {
//     final _response = await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .get()
//         .then((QuerySnapshot value) =>
//             value.docs.firstWhere((element) => element['id'] == productID));
//     ProductModel _l;
//     if (_response.exists) {
//       _l = ProductModel.fromMap(_response.data());
//       return _l;
//     } else {
//       print('api Error@getProductByID');
//       // Err
//       throw _l;
//     }
//   }
//
//   //////////////////updatePoundsInProduct//////////////////
//
//   Future<void> updatePoundsInProductDEC(String productId, int quantity) async {
//     await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .doc(productId)
//         .update({
//       ProductCollection.POUNDS: FieldValue.increment(-quantity),
//     });
//   }
//
//   Future<void> updatePoundsInProductINC(CartModel cart) async {
//     await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .doc(cart.productId)
//         .update({
//       ProductCollection.POUNDS: FieldValue.increment(cart.quantity),
//     });
//   }
//
//   ////////////////////ORDERS///////////////////////////////
//
//   Future<void> addOrder(OrderModel orderModel) async {
//     final DocumentReference data = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .add(orderModel.toMap());
//
//     await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .doc(data.id)
//         .update({OrderCollection.ORDER_ID: data.id});
//   }
//
//   ////////////////////////ADD CART//////////////////////
//
//   Future<void> sendCart(CartModel cartModel) async {
//     final DocumentReference data = await firestore
//         .collection(UserData.USER_DATA_TABLE)
//         .doc(cartModel.userId)
//         .collection(Cart.TABLE_NAME)
//         .add(cartModel.toMapWithoutProduct());
//     await firestore
//         .collection(UserData.USER_DATA_TABLE)
//         .doc(cartModel.userId)
//         .collection(Cart.TABLE_NAME)
//         .doc(data.id)
//         .update({Cart.CART_ID: data.id});
//   }
//
//   ///////////////GET Cart BY ID////////////////////////
//
//   Future<CartModel> getCartByID(String cartID) async {
//     final _response = await firestore.collection(Cart.TABLE_NAME).get().then(
//         (QuerySnapshot value) =>
//             value.docs.firstWhere((element) => element['cartId'] == cartID));
//     CartModel _c;
//     if (_response.exists) {
//       _c = CartModel.fromMap(_response.data());
//       return _c;
//     } else {
//       print('api Error@getCartByID');
//       // Err
//       throw _c;
//     }
//   }
//
//   //////////// Update products //////////////////
//   Future<void> updateProduct(ProductModel product) async {
//     await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .doc(product.id)
//         .update(product.toMap());
//   }
//   ///////////////////////////////////////////////
//
//   /////////// Delete Course ///////////////////
//   Future<void> deleteCourse(String courseCode) async {
//     await firestore
//         .collection(CourseData.NAME)
//         .where(courseCode, isEqualTo: CourseData.CODE)
//         .get()
//         .delete();
//   }
//
//   Future<void> deleteFireBaseStorageImage(String filePath) async {
//     await FirebaseStorage.instance.ref().child(filePath).delete().whenComplete(
//         () => print('Successfully deleted $filePath storage item'));
//   }
//
//   /////////// Delete Ordered Cart ///////////////////
//   //TODO delete by cart id
//   Future<void> deleteOrderedCart(String farmerId) async {
//     await firestore
//         .collection(UserData.USER_DATA_TABLE)
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .collection(Cart.TABLE_NAME)
//         .where(Cart.FARMER_ID, isEqualTo: farmerId)
//         .get()
//         .then((value) async {
//       final db = firestore.batch();
//
//       for (final i in value.docs) {
//         db.delete(i.reference);
//       }
//
//       await db.commit();
//     });
//   }
//
//   ///////////////GET CART DATA//////////////////////////
//
//   Future<List<CartModel>> getCartData(String userID) async {
//     final _cart = await firestore
//         .collection(UserData.USER_DATA_TABLE)
//         .doc(userID)
//         .collection(Cart.TABLE_NAME)
//         .where(Cart.USER_ID, isEqualTo: userID)
//         .get();
//     if (_cart.docs.isNotEmpty) {
//       final _c = <CartModel>[];
//       _cart.docs.forEach((element) {
//         _c.add(CartModel.fromMap(element.data()));
//       });
//
//       return _c;
//     } else {
//       print('api Error@getCartData');
//       // Err
//       throw _cart;
//     }
//   }
//
//   //////////////////////////////////////////////////////////////////
//
//   Future<bool> checkOnProductId(String productId, String uid) async {
//     bool exists = false;
//     try {
//       final data = await firestore
//           .collection(UserData.USER_DATA_TABLE)
//           .doc(uid)
//           .collection(Cart.TABLE_NAME)
//           .where(Cart.PRODUCT_ID, isEqualTo: productId)
//           .get();
//       if (data.docs.isNotEmpty) {
//         exists = true;
//       } else
//         exists = false;
//       return exists;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   /////////////////GET ORDERS DATA/////////////////////////////
//   Future<List<OrderModel>> getClientOrdersData(String clientID) async {
//     final _order = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .where(OrderCollection.CLIENT_ID, isEqualTo: clientID)
//         .get();
//     final _o = <OrderModel>[];
//     if (_order.docs.isNotEmpty) {
//       _order.docs.forEach((element) {
//         _o.add(OrderModel.fromMap(element.data()));
//       });
//
//       return _o;
//     } else {
//       print('api Error@getClientOrdersData');
//       // Err
//       return _o;
//     }
//   }
//
// /////////////////GET PROVIDER ORDERS DATA/////////////////////////////
//   Future<List<OrderModel>> getProviderOrdersData(String providerID) async {
//     final _order = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .where(OrderCollection.PROVIDER_ID, isEqualTo: providerID)
//         .get();
//     final _o = <OrderModel>[];
//     _order.docs.forEach((element) {
//       _o.add(OrderModel.fromMap(element.data()));
//     });
//
//     return _o;
//   }
//
//   /////////// Delete order ///////////////////
//   Future<void> deleteOrder(String orderID) async {
//     await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .doc(orderID)
//         .delete();
//   }
//
//   ///////////////////////////////////////////////////////
//   ///////////////////// Get Orders For Delivery //////////
//   Future<List<OrderModel>> getAllOrdersForDelivery(String status) async {
//     final _order = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .where(OrderCollection.STATUS, isEqualTo: status)
//         .get();
//     final _o = <OrderModel>[];
//     _order.docs.forEach((element) {
//       _o.add(OrderModel.fromMap(element.data()));
//     });
//
//     return _o;
//   }
//
//   ///////////////////// Get History For Delivery //////////
//   Future<List<OrderModel>> getDeliveryHistory() async {
//     final _order = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .where(OrderCollection.STATUS, isEqualTo: OrderCollection.DELIVERED)
//         .where(
//           OrderCollection.DELIVERY_ID,
//           isEqualTo: FirebaseAuth.instance.currentUser.uid,
//         )
//         .get();
//     final _o = <OrderModel>[];
//     _order.docs.forEach((element) {
//       _o.add(OrderModel.fromMap(element.data()));
//     });
//
//     return _o;
//   }
//   ////////////////////////////////update order data when delivery accept the order//////////////////////
//
//   Future<void> updateOrderDataAfterDeliveryAccept(
//       String orderId,
//       String deliveryName,
//       String deliveryNumber,
//       String deliveryId,
//       String status) async {
//     await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .doc(orderId)
//         .update({
//       OrderCollection.DELIVERY_NUMBER: deliveryNumber,
//       OrderCollection.DELIVERY_NAME: deliveryName,
//       OrderCollection.DELIVERY_ID: deliveryId,
//       OrderCollection.STATUS: status,
//     });
//   }
//
//   ////////////////////////////////update order data when delivery cancel the order//////////////////////
//
//   Future<void> updateOrderDataAfterDeliveryCancel(
//       String orderId, String status) async {
//     await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .doc(orderId)
//         .update({
//       OrderCollection.DELIVERY_NUMBER: null,
//       OrderCollection.DELIVERY_NAME: null,
//       OrderCollection.DELIVERY_ID: null,
//       OrderCollection.STATUS: status,
//     });
//   }
//
//   Future<void> updateOrderDataStatus(String orderId, String status) async {
//     await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .doc(orderId)
//         .update({
//       OrderCollection.STATUS: status,
//     });
//   }
//
//   /////////////////GET ORDER STATUS /////////////////////////////
//   Future<String> getOrdersStatus(String orderID) async {
//     final _status = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .where(OrderCollection.ORDER_ID, isEqualTo: orderID)
//         .get();
//
//     final _s = <OrderModel>[];
//     if (_status.docs.isNotEmpty) {
//       _status.docs.forEach((element) {
//         _s.add(OrderModel.fromMap(element.data()));
//       });
//
//       return _s.first.status;
//     }
//   }
//
//   ////////////////////////////////get soldOut Product/////////////////////////////////////////
//   Future<List<ProductModel>> getSoldOutProduct(String type) async {
//     final _response = await firestore
//         .collection(ProductCollection.PRODUCTS_TABLE)
//         .where(ProductCollection.POUNDS, isEqualTo: 0)
//         .where(ProductCollection.TYPE, isEqualTo: type)
//         .where(ProductCollection.FARMER_ID,
//             isEqualTo: FirebaseAuth.instance.currentUser.uid)
//         .get();
//     final _soldOut = <ProductModel>[];
//     if (_response.docs.isNotEmpty) {
//       _response.docs.forEach((element) {
//         _soldOut.add(ProductModel.fromMap(element.data()));
//       });
//
//       return _soldOut;
//     } else {
//       print('api Error@getSoldOutProduct no soldOut product');
//       // Err
//       return _soldOut;
//     }
//   }
//   /////////////////////// delete specific product in cart/////////////////
//
//   Future<void> deleteSpecificProductInCart(String cartId) async {
//     await firestore
//         .collection(UserData.USER_DATA_TABLE)
//         .doc(FirebaseAuth.instance.currentUser.uid)
//         .collection(Cart.TABLE_NAME)
//         .doc(cartId)
//         .delete();
//   }
//   /////////////////////// Get Order Accepted By Transporter /////////////////
//
//   Future<List<OrderModel>> getOrderAcceptedByTransporter(
//       String transporterID) async {
//     final _response = await firestore
//         .collection(OrderCollection.ORDERS_TABLE)
//         .where(OrderCollection.DELIVERY_ID, isEqualTo: transporterID)
//         .where(OrderCollection.STATUS, isNotEqualTo: OrderCollection.DELIVERED)
//         .get();
//
//     final _o = <OrderModel>[];
//     _response.docs.forEach((element) {
//       _o.add(OrderModel.fromMap(element.data()));
//     });
//
//     return _o;
//   }
}
