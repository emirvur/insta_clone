/*import 'package:flutter/material.dart';
import 'package:insta/ui/home.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserModel>(context,listen: true); 
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user == null) {
        return SignInPage();
      } else {
        return ProfilePage();   //Home(user: _userModel.user,);
      }
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}*/
