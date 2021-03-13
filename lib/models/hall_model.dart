import 'package:elgam3a_admin/services/vars.dart';

class HallModel {
  int id;
  int capacity;
  // String location;
  List<String> times = [
    '8:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
    '6:00 PM - 8:00 PM',
  ];

  HallModel({this.id, this.capacity});

  HallModel.fromMap(Map<String, dynamic> m) {
    id = m[HallData.ID];
    capacity = m[HallData.CAPACITY];
    // location = m[HallData.LOCATION];
  }

  Map<String, dynamic> toMap() {
    return {
      HallData.ID: id,
      HallData.CAPACITY: capacity,
      // HallData.LOCATION: location,
      HallData.TIMES: times,
    };
  }

  @override
  String toString() {
    return 'Hall $id';
  }
}
