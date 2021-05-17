/*import 'package:flutter/material.dart';
import 'package:insta/model/user.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {

  final User user;

  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar:AppBar(
            title:Text("fsdd"),
            actions: <Widget>[RaisedButton(onPressed: ()async{
              debugPrint("22!!!!!!!!!!!!!!!!!!!!!!");
   final _userModell = Provider.of<UserModel>(context,listen:false);
   
  await _userModell.signOut();
  if(_userModell.user==null){
    Navigator.of(context).push(MaterialPageRoute(
      
        builder: (context) => SignInPage()
      ));
  }
            },child: Text("signout"), )],
          ),
          body: Text("vfhhj")
    );
  }
}*/
