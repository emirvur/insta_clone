import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String userID;
  String userName;
  //String profilURL;
  String bio;
  int followers;
  int followings;
  int posts;
  String searchKey;

  User(
      {@required this.userID,
      this.userName,
      this.bio,
      // this.profilURL,
      this.posts,
      this.followers,
      this.followings,
      this.searchKey});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName ?? "ilk",
      'bio': bio ?? "fff",
      'posts': posts ?? 0,
      'followers': followers ?? 0,
      'followings': followings ?? 0,
      'searchKey': userName.substring(0, 1).toLowerCase() ?? "",
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        bio = map['bio'],
        userName = map['userName'],
        //profilURL = map['profilURL'],
        followings = (map['followings']),
        followers = (map['followers']),
        posts = map['posts'];

//  User.idveResim({@required this.userID, @required this.profilURL});

}
