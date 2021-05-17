import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/locator.dart';
import 'package:insta/model/user.dart';
import 'package:insta/services/firebase_auth_service.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //FirebaseAuthService authlocator = locator<FirebaseAuthService>();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  FirebaseAuthService authlocator = locator<FirebaseAuthService>();
  String _name, _email, _password, bio;

  checkAuthincation() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
//

        //
        // _auth.signOut();
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacementNamed(context, '/splash');
          // Here you can write your code for open new view
        });

        // Navigator.pushReplacementNamed(context, '/splash');
      }
    });
  }

  navigateToSignInScreen() {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthincation();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  signup() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      try {
        setState(() async {
          AuthResult user = await _auth.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );

          await dblocator
              .saveUser(User(userID: user.user.uid, userName: _name, bio: bio));

          UserModel userr = Provider.of<UserModel>(context, listen: false);
          await userr.currentUser();
        });
      } catch (e) {
        showError(e);
      }
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text('Sign Up'),
//      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 100, 30, 40),
        child: Center(
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 20,
                /*     shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                )),*/
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
//                        Name box
                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return 'Kullanıcı adı girin';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Kullanıcı adınızı giriniz'),
                                onSaved: (input) => _name = input,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
//                      email

                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                textCapitalization:
                                    TextCapitalization.characters,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return 'Bionuzu girin';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Bionuzu giriniz'),
                                onSaved: (input) => bio = input,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),

                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                validator: (input) {
                                  if (input.isEmpty) {
                                    return 'Email girin';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'E-mail'),
                                onSaved: (input) => _email = input,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            Container(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                validator: (input) {
                                  if (input.length < 6) {
                                    return 'Şifre en az 6 karakterden oluşmalıdır';
                                  }
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding: EdgeInsets.all(15),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    ),
                                    filled: true,
                                    fillColor: Colors.black,
                                    focusColor: Colors.black,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Şifre'),
                                onSaved: (input) => _password = input,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
//                    button
                            RaisedButton(
                                padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(30),
                                ),
                                onPressed: signup,
                                child: Text(
                                  'Kaydol',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
//                      redirect to signup page
                            Padding(
                              padding: EdgeInsets.all(10),
                            ),
                            GestureDetector(
                              onTap: navigateToSignInScreen,
                              child: Text(
                                'Zaten üyeseniz buraya tıklayınız',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
