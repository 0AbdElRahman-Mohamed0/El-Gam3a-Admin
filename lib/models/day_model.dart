class DayModel {
  String name;
  List<String> times = [
    '8:00 AM - 10:00 AM',
    '10:00 AM - 12:00 PM',
    '12:00 PM - 2:00 PM',
    '2:00 PM - 4:00 PM',
    '4:00 PM - 6:00 PM',
    '6:00 PM - 8:00 PM',
  ];

  DayModel({
    this.name,
    this.times,
  });

  DayModel copyWith({
    String name,
    List<String> times,
  }) {
    return DayModel(
      name: name ?? this.name,
      times: times ??
          [
            '8:00 AM - 10:00 AM',
            '10:00 AM - 12:00 PM',
            '12:00 PM - 2:00 PM',
            '2:00 PM - 4:00 PM',
            '4:00 PM - 6:00 PM',
            '6:00 PM - 8:00 PM',
          ],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'times': times,
    };
  }
}
