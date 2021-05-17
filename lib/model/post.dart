import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  String userID;
  String userName;
  String fotoURL;
  String description;
  String createdAt;
  bool isliked;

  Post({
    this.userID,
    this.userName,
    this.fotoURL,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'fotoURL': fotoURL,
      'description': description,
      'createdAt': DateTime.now().toString(),
      'isliked': isliked ?? false,
    };
  }

  Post.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        userName = map['userName'],
        fotoURL = map['fotoURL'],
        description = (map['description']),
        isliked = (map['isliked']),
        createdAt = map['createdAt'];
  //(map['createdAt'] as Timestamp).toDate();
}
