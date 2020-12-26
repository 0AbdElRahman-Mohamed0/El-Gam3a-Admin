import 'package:elgam3a_admin/services/vars.dart';

class UserModel {
  String email;
  String name;
  String department;
  String minor;
  String type;
  String phoneNumber;
  String univID;
  String imageUrl;
  String imagePath;
  String userID;

  UserModel({
    this.type,
    this.name,
    this.email,
    this.department,
    this.minor,
    this.phoneNumber,
    this.univID,
    this.imageUrl,
    this.userID,
    this.imagePath,
  });
  UserModel.fromMap(Map<String, dynamic> m) {
    email = m[UserData.EMAIL];
    department = m[UserData.MAJOR];
    minor = m[UserData.MINOR];
    name = m[UserData.NAME];
    type = m[UserData.TYPE];
    phoneNumber = m[UserData.PHONE_NUMBER];
    univID = m[UserData.UNIV_ID];
    imageUrl = m[UserData.IMAGE_URL];
    imagePath = m[UserData.IMAGE_PATH];
    userID = m[UserData.ID];
  }

  Map<String, dynamic> toMap() {
    return {
      UserData.EMAIL: email,
      UserData.MAJOR: department,
      UserData.MINOR: minor ?? '',
      UserData.NAME: name,
      UserData.TYPE: type,
      UserData.PHONE_NUMBER: phoneNumber,
      UserData.UNIV_ID: univID,
      UserData.IMAGE_URL: imageUrl ?? '',
      UserData.IMAGE_PATH: imagePath ?? '',
      UserData.ID: userID,
    };
  }

  UserModel copyWith({
    String email,
    String name,
    String department,
    String minor,
    String type,
    String phoneNumber,
    String univNumber,
    String imageUrl,
    String imagePath,
    String userID,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      department: department ?? this.department,
      minor: minor ?? this.minor,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      univID: univNumber ?? this.univID,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      userID: userID ?? this.userID,
    );
  }
}
