class Caption {
  int id;
  int recepieId;
  String caption; //The file path to the stored picture

  Caption({
    required this.id,
    required this.recepieId,
    required this.caption,
  });

  Map<String, dynamic> toMap(int rID) {
    return {
      'recepieId': rID,
      'caption': caption,
    };
  }

  static Caption fromJSON(Map map) {
    Caption caption = Caption(
      id: -1,
      recepieId: -1,
      caption: map['caption'],
    );
    return caption;
  }

  static Caption fromDB(Map map) {
    Caption caption = Caption(
      id: map['id'],
      recepieId: map['recepieId'],
      caption: map['caption'],
    );
    return caption;
  }
}
