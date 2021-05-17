import 'package:flutter/material.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _controllerUserName;
  TextEditingController bio;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String username;
  String biograhp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerUserName = TextEditingController();
    bio = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel _ll = Provider.of<UserModel>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Profili duzenle"),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                //  debugPrint("22!!!!!!!!!!!!!!!!!!!!!!");

                setState(() {
                  final _userModel =
                      Provider.of<UserModel>(context, listen: false);
                  _formKey.currentState.save();

                  _userModel.updateUser(
                      _userModel.user.userID, username, biograhp);
                  //   _userModel.currentUser();
                  Navigator.of(context).pop(() {});
                });
              },
              child: Text(
                "Güncelle",
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
                onPressed: () {
                  debugPrint("onceki krana donuldu");
                  Navigator.of(context).pop();
                },
                child: Text("İptal", style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _ll.user.userName,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.verified_user),
                      hintText: 'username',
                      labelText: 'username',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String girilen) {
                      username = girilen;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    initialValue: _ll.user.bio,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      hintText: 'bio',
                      labelText: 'bio',
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String girilenbio) {
                      biograhp = girilenbio;
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              )),
        ));
  }
}
