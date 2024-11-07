class Caption {
  int id;
  int recepieId;
  String caption; //The file path to the stored picture

  Caption({
    required this.id,
    required this.recepieId,
    required this.caption,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, //is this necesary?
      'recepieId': recepieId,
      'caption': caption,
    };
  }

  static Caption fromMap(Map map) {
    Caption caption = Caption(
      id: map['id'],
      recepieId: map['recepieId'],
      caption: map['caption'],
    );
    return caption;
  }
}
