abstract class UserData {
  static const String USER_DATA_TABLE = "user_data";
  static const String NAME = "name";
  static const String ID = "userID";
  static const String MAJOR = "department";
  static const String DIVISION = "division";
  static const String MINOR = "minor";
  static const String EMAIL = "email";
  static const String TYPE = "type";
  static const String PHONE_NUMBER = 'phone_number';
  static const String UNIV_ID = 'univ_ID';
  static const String IMAGE_URL = 'image';
  static const String IMAGE_PATH = 'imagePath';
}

abstract class ProductCollection {
  static const String PRODUCTS_TABLE = "products";
  static const String NAME = "name";
  static const String ID = "id";
  static const String IMAGE_URL = "imageUrl";
  static const String EXPIRE_DATE = "expireDate";
  static const String UPLOADED_DATE = "uploadedDate";
  static const String POUNDS = "pounds";
  static const String TYPE = "type";
  static const String DESCRIPTION = "description";
  static const String FARMER_ID = "farmerId";
  static const String IMAGE_PATH = "imagePath";
}

abstract class Cart {
  static const String TABLE_NAME = "cart";
  static const String PRODUCT_ID = "productId";
  static const String USER_ID = "userId";
  static const String QUANTITY = "quantity";
  static const String FARMER_ID = "farmerId";
  static const String PRODUCT = "product";
  static const String CART_ID = "cartId";
}

abstract class OrderCollection {
  static const String ORDERS_TABLE = "orders";
  static const String STATUS = "status";
  static const String PENDING = "pending";
  static const String ACCEPTED = "accepted";
  static const String ON_DELIVERY = "onDelivery";
  static const String DELIVERED = "delivered";
  static const String CLIENT_NAME = "clientName";
  static const String CLIENT_NUMBER = "clientNumber";
  static const String CLIENT_ADDRESS = "clientAddress";
  static const String CLIENT_ID = "clientId";
  static const String PROVIDER_NAME = "providerName";
  static const String PROVIDER_NUMBER = "providerNumber";
  static const String PROVIDER_ADDRESS = "providerAddress";
  static const String PROVIDER_ID = "providerId";
  static const String ORDER_ID = "orderId";
  static const String DELIVERY_NAME = "deliveryName";
  static const String DELIVERY_NUMBER = "deliveryNumber";
  static const String DELIVERY_ID = "deliveryID";
  static const String CART = "cart";
}
