import 'package:elgam3a_admin/services/vars.dart';

class UserModel {
  String email;
  String name;
  String division;
  String department;
  String gpa;
  String completedHours;
  String registeredHours;
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
    this.division,
    this.department,
    this.minor,
    this.gpa,
    this.completedHours,
    this.registeredHours,
    this.phoneNumber,
    this.univID,
    this.imageUrl,
    this.userID,
    this.imagePath,
  });
  UserModel.fromMap(Map<String, dynamic> m) {
    email = m[UserData.EMAIL];
    division = m[UserData.DIVISION];
    department = m[UserData.MAJOR];
    gpa = m[UserData.GPA];
    completedHours = m[UserData.COMPLETED_HOURS];
    registeredHours = m[UserData.REGISTERED_HOURS];
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
      UserData.DIVISION: division,
      UserData.GPA: gpa ?? '0',
      UserData.COMPLETED_HOURS: completedHours ?? '0',
      UserData.REGISTERED_HOURS: registeredHours ?? '0',
      UserData.MAJOR: department ?? '',
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
    String division,
    String gpa,
    String completedHours,
    String registeredHours,
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
      division: division ?? this.division,
      gpa: gpa ?? this.gpa,
      completedHours: completedHours ?? this.completedHours,
      registeredHours: registeredHours ?? this.registeredHours,
      department: department ?? this.department,
      minor: minor ?? this.minor,
      type: type ?? this.type,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      univID: univID ?? this.univID,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      userID: userID ?? this.userID,
    );
  }
}
