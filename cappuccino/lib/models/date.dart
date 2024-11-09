class Date {
  int id;
  int recepieId;
  int year;
  int month;
  int day;

  Date({
    required this.id,
    required this.recepieId,
    required this.year,
    required this.month,
    required this.day,
  });

  Map<String, dynamic> toMap(int rID) {
    return {
      'recepieId': rID,
      'year': year,
      'month': month,
      'day': day,
    };
  }

  static Date fromJSON(Map map) {
    return Date(
      id: -1,
      recepieId: -1,
      year: map['year'],
      month: map['month'],
      day: map['day'],
    );
  }

  static Date fromDB(Map map) {
    return Date(
      id: map['id'],
      recepieId: map['recepieId'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
    );
  }
}
