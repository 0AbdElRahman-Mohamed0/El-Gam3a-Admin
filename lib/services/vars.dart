abstract class UserData {
  static const String USER_DATA_TABLE = "user_data";
  static const String NAME = "name";
  static const String ID = "userID";
  static const String GPA = "gpa";
  static const String COMPLETED_HOURS = "completed_hours";
  static const String REGISTERED_HOURS = "registered_hours";
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

abstract class CourseData {
  static const String COURSE_TABLE = "course_data";
  static const String ID = "id";
  static const String NAME = "name";
  static const String CODE = "code";
  static const String DOCTOR = "doctor";
  static const String ASSISTANTS = "assistants";
  static const String LOCATION = "location";
  static const String DAY = "day";
  static const String TIME = "time";
  static const String HALL = "hall";
  static const String CREDIT_HOURS = "credit_hours";
  static const String DEPARTMENT = "department";
  static const String REQUIRED = 'required';
}
