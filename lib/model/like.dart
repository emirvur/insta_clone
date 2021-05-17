class Like {
  bool like;
  String fotourl;
  String takipciad;

  Like({this.like, this.fotourl, this.takipciad});

  Map<String, dynamic> toMap() {
    return {'like': like, 'fotourl': fotourl, 'takipciad': takipciad};
  }

  Like.fromMap(Map<String, dynamic> map)
      : like = map['like'],
        fotourl = map['fotourl'],
        takipciad = map['takipciad'];
}
