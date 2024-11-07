class Date {
  int id;
  int year;
  int month;
  int day;

  Date({
    required this.id,
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
      id: -1,
      year: map['year'],
      month: map['month'],
      day: map['day'],
    );
  }

  static Date fromDB(Map map) {
    return Date(
      id: map['id'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
    );
  }
}
