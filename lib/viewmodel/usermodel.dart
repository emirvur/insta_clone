//import 'dart:html';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/locator.dart';
import 'package:insta/model/user.dart';
import 'package:insta/services/firebase_auth_service.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/services/firebase_storage.dart';

enum ViewState { Idle, Busy }

class UserModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;
  FirebaseAuthService authlocator = locator<FirebaseAuthService>();
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  FirebaseStorageService strlocator = locator<FirebaseStorageService>();
  User _user = User(
      userID: "",
      userName: ""); //user normlde nulldı onu ıd ve nameıne bos deger atadım

  User get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  Future<User> currentUser() async {
    /* try {
      state = ViewState.Busy;
     authlocator.currentUser().then((value) async {
  if (value!= null){
    debugPrint("!!!!!!firebasedn okuma yapılıyor");
    _user= await  dblocator.readUser(value.userID);
     
  
     return _user; 
      }
  else{
return null; 
}     });     
     }*/

    try {
      state = ViewState.Busy;

      User x = await authlocator.currentUser();
      if (x != null) {
        debugPrint("!!!!!!firebasedn okuma yapılıyor");
        User a = await dblocator.readUser(x.userID);
        _user = a;
        //  debugPrint("!!!!profil kısm ${_user.profilURL}");
        return _user;
      } else {
        debugPrint("firebaseden okuma ypılmadı!!!!!!!");
        return null;
      }
    } catch (e) {
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      bool sonuc = await authlocator.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return false;
    } finally {
      debugPrint("!!!!!!!signout calisti");
      state = ViewState.Idle;
    }
  }

  Future<User> createUserWithEmailandPassword(
      String email, String sifre) async {
    try {
      state = ViewState.Busy;
      _user = await authlocator.createUserWithEmailandPassword(email, sifre);
      if (_user != null) {
        await dblocator.saveUser(_user);
        return _user;
      } else
        return null;
    } catch (e) {
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  Future<User> signInWithEmailandPassword(String email, String sifre) async {
    try {
      state = ViewState.Busy;
      _user = await authlocator.signInWithEmailandPassword(email, sifre);
      return _user;
      //   if (_emailSifreKontrol(email, sifre)) {     }

    } catch (e) {
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  /* bool _emailSifreKontrol(String email, String sifre) {
    var sonuc = true;

    if (sifre.length < 6) {
      sifreHataMesaji = "En az 6 karakter olmalı";
      sonuc = false;
    } else
      sifreHataMesaji = null;
    if (!email.contains('@')) {
      emailHataMesaji = "Geçersiz email adresi";
      sonuc = false;
    } else
      emailHataMesaji = null;
    return sonuc;
  }*/

  Future<User> readuser(String x) async {
    User user = await dblocator.readUser(x);
    return user;
  }

//providerı daha iyi anlamak için navigator poptaki set statei kaldır altta viewstatelerle oyna
  Future<void> updateUser(
      String userID, String yeniUserName, String bio) async {
    await dblocator.updateUser(userID, yeniUserName, bio);
    currentUser();
    _user.userName = yeniUserName;
    _user.bio = bio;
  }

  Future<String> uploadFile(String userID, File profilFoto) async {
    var indirmeLinki = await strlocator.uploadFile(userID, profilFoto);
    return indirmeLinki;
  }
}
