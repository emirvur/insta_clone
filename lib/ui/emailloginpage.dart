import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta/model/user.dart';
import 'package:insta/ui/home.dart';
import 'package:insta/ui/home.dart';
import 'package:insta/ui/home.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

enum FormType { Register, LogIn }

class EmailveSifreLoginPage extends StatefulWidget {
  @override
  _EmailveSifreLoginPageState createState() => _EmailveSifreLoginPageState();
}

class _EmailveSifreLoginPageState extends State<EmailveSifreLoginPage> {
  String _email, _sifre;
  String _butonText;
  String _linkText;
  var _formType = FormType.LogIn;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    //debugPrint("email :" + _email + " şifre:" + _sifre);

    final _userModel = Provider.of<UserModel>(context, listen: false);

    if (_formType == FormType.LogIn) {
      try {
        User _girisYapanUser =
            await _userModel.signInWithEmailandPassword(_email, _sifre);
        // dblocator.saveUser(_girisYapanUser);
        //if (_girisYapanUser != null)
        //print("Oturum açan user id:" + _girisYapanUser.userID.toString());
      } catch (e) {
        print("!!!!!!!!!!!!!!!!!!!!!hata:" + e.toString());
        return;
      }
    } else {
      try {
        User _olusturulanUser =
            await _userModel.createUserWithEmailandPassword(_email, _sifre);

        /* if (_olusturulanUser != null)
          print("Oturum açan user id:" + _olusturulanUser.userID.toString());*/
      } catch (e) {
        print("!!!!!!!!!!!!!!!!!!!!!!!!hata:" + e.toString());
        return;
      }
    }
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.LogIn ? FormType.Register : FormType.LogIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    _butonText = _formType == FormType.LogIn ? "Giriş Yap " : "Kayıt Ol";
    _linkText = _formType == FormType.LogIn
        ? "Hesabınız Yok Mu? Kayıt Olun"
        : "Hesabınız Var Mı? Giriş Yapın";
    final _userModel = Provider.of<UserModel>(context);

    if (_userModel.user != null) {
      //  bunu denemelisin   Future.delayed(Duration(milliseconds: 1),(){
      //   Navigator.of(context).popUntil(ModalRoute.withName("/"));    });
      //  cift tırnakın ıcı signin de oalbilr

      Navigator.pushNamed(context, '/feed');

      /*    Future.delayed(Duration(milliseconds: 1), () {
        Navigator.of(context).  popUntil(ModalRoute.withName("/")
    );                   
      });*/
    }

    /*   .push (MaterialPageRoute(
      
        builder: (context) => HomePage(),
      )*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş / Kayıt"),
      ),
      body: _userModel.state == ViewState.Idle
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          //initialValue: "emre@emre.com",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenEmail) {
                            _email = girilenEmail;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          //initialValue: "password",
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Sifre',
                            labelText: 'Sifre',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilenSifre) {
                            _sifre = girilenSifre;
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RaisedButton(
                          child: Text(_butonText),
                          onPressed: () => _formSubmit(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                          onPressed: () => _degistir(),
                          child: Text(_linkText),
                        ),
                      ],
                    )),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
