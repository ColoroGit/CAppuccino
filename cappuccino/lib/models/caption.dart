class Caption {
  int? id;
  int? recepieId;
  String caption; //The file path to the stored picture

  Caption({
    required this.caption,
  });

  Map<String, dynamic> toMap(int? rID) {
    return {
      // 'id': id, //is this necesary?
      'recepieId': rID,
      'caption': caption,
    };
  }

  static Caption fromMap(Map map) {
    Caption caption = Caption(
      caption: map['caption'],
    );
    return caption;
  }
}
