class Comment {
  String userName;
  String fotoURL;
  String comment;

  Comment({
    this.userName,
    this.fotoURL,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'fotoURL': fotoURL,
      'description': comment,
    };
  }

  Comment.fromMap(Map<String, dynamic> map)
      : userName = map['userName'],
        fotoURL = map['fotoURL'],
        comment = (map['comment']);
}
