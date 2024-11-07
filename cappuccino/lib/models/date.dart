class Date {
  int? id;
  int year;
  int month;
  int day;

  Date({
    required this.year,
    required this.month,
    required this.day,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id, //is this necesary?
      'year': year,
      'month': month,
      'day': day,
    };
  }

  static Date fromJSON(Map map) {
    return Date(
      year: map['year'],
      month: map['month'],
      day: map['day'],
    );
  }
}
