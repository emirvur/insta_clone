import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta/locator.dart';

import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/ui/commentpage.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  List liste;
  bool flag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    debugPrint("tekrardan yappp");

    return Scaffold(
/*appBar: AppBar(
        title: Text('BottomNavigationBar'),
             actions: <Widget>[
               
               RaisedButton(onPressed: ()async{
              debugPrint("22!!!!!!!!!!!!!!!!!!!!!!");
   final _userModel = Provider.of<UserModel>(context,listen:false);
  await _userModel.signOut();
  debugPrint("raisedbu!!!");
  if(_userModel.user==null){
    /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      
        builder: (context) => LandingPage()),(Route<dynamic> route) => false
      );*/
      Navigator.of(context).push(MaterialPageRoute(
      
        builder: (context) => SearchPage()
      ));
  }
            },child: Text("signout"), ),
        //   RaisedButton(onPressed: (){            debugPrint("22!!!!!!!!!!!!!!!!!!!!!!"); Navigator.of(context).push(MaterialPageRoute(      builder: (context) => HomePage() ));  },  child: Text("bitti")        )
           ]
      ),*/

      body: Column(
        children: <Widget>[
          _appBar(),
          _profile(),
          //  _centerButtons(),
          _displayImages()
        ],
      ),
    );
  }

  Widget _appBar() {
    UserModel userr = Provider.of<UserModel>(context);
    return new Container(
      color: Colors.white,
      padding: new EdgeInsets.only(top: 25.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Text(
                  "Profil",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              IconButton(
                icon: new Icon(Icons.exit_to_app),
                iconSize: 25.0,
                onPressed: () {
                  _auth.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignIn()),
                      (Route<dynamic> route) => false);
                },
              )
            ],
          ),
          new Container(
            margin: new EdgeInsets.only(top: 2.0),
            height: 3.5,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _post() {
    UserModel ser = Provider.of<UserModel>(context);

    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          ser.user.userID.length == 0
              ? CircularProgressIndicator()
              : Text(ser.user.posts.toString()),
          //new Text(
          // ser.user == null ? "65" : ser.user.posts.toString() ?? "dd",
          //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          //   ),
          new Padding(
            padding: new EdgeInsets.only(top: 3.0),
            child: new Text(
              "posts",
              style: new TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget _followers() {
    UserModel ser = Provider.of<UserModel>(context, listen: false);
    debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!fdd");
    return new Container(
      margin: new EdgeInsets.only(left: 10.0),
      child: new GestureDetector(
        child: new Column(
          children: <Widget>[
            ser.user.userID.length == 0
                ? CircularProgressIndicator()
                : Text(ser.user.followers.toString()),
            //   new Text(
            // ser.user == null ? "65" : ser.user.followers.toString() ?? "dd",
            //   style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            //   ),
            new Padding(
              padding: new EdgeInsets.only(top: 3.0),
              child: new Text(
                "takipçi",
                style: new TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _following() {
    UserModel ser = Provider.of<UserModel>(context);
    debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!hhhhhhhhhhhhhh");
    return new Container(
      margin: new EdgeInsets.only(left: 10.0),
      child: new GestureDetector(
        child: new Column(
          children: <Widget>[
            ser.user.userID.length == 0
                ? CircularProgressIndicator()
                : Text(ser.user.followings.toString()),
            //   Text(
            //    ser.user == null ? "65" : ser.user.followings.toString() ?? "dd",
            //    style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            //   ),
            new Padding(
              padding: new EdgeInsets.only(top: 3.0),
              child: new Text(
                "takip",
                style: new TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _profile() {
    UserModel ser = Provider.of<UserModel>(context);
    //  ser.currentUser();
    return new Container(
      height: 120.0,
      margin: new EdgeInsets.only(top: 5.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        //      Navigator.pushNamed(context, '/upload');
                      },
                      child: Text(ser.user.userName,
                          style: new TextStyle(
                              fontWeight: FontWeight
                                  .bold)) /*Image.network(
                      ser.user.profilURL == null
                          ? 'https://www.google.com/url?sa=i&url=http%3A%2F%2Ffatihsanatmerkezi.com%2Fportfolio%2Fresim%2F&psig=AOvVaw1YQiVRDSfDqXXtXFJCaoG-&ust=1594322255825000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCOjAlrevvuoCFQAAAAAdAAAAABAD'
                          : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.klasiksanatlar.com%2Ficerik%2Fegitim%2F35%2Fres%25C4%25B1m.html&psig=AOvVaw1xIANxhwrBjJ8fwnSG6DxV&ust=1594322473470000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCNCn456wvuoCFQAAAAAdAAAAABAD', //ser.user.profilURL,
                      //     height: 100.0,
                    ),*/
                      ),
                  new Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    alignment: Alignment.bottomLeft,
                    child: ser.user.userID.length == 0
                        ? CircularProgressIndicator()
                        : Text(
                            "Bio: ${ser.user.bio.toString()}",
                            style: TextStyle(fontSize: 12.0),
                          ),
                    //new Text(
                    //ser.user == null
                    //    ? "Kullanıcı adı"
                    //      : ser.user.bio.toString() ?? "dd",
                    //    style: new TextStyle(fontWeight: FontWeight.w100),
                    //    ),
                  ),
                ],
              ),
              new Container(
                margin: EdgeInsets.only(bottom: 25.0),
                child: new Column(
                  children: <Widget>[
                    new Container(
                      child: new Row(
                        children: <Widget>[_post(), _followers(), _following()],
                      ),
                    ),
                    new GestureDetector(
                      child: new Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        margin: EdgeInsets.only(top: 7.0),
                        height: 30.0,
                        width: 200.0,
                        child: new Text(
                          "Hesabını güncelle  ",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/editprofile');
                        //    authlocator.signOut();
                        /*      Navigator.of(context).pushAndRemoveUntil(
                          '/signin', (Route<dynamic> route) => false /*'/EditProfile'*/);*/
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          /*      new Container(
            margin: new EdgeInsets.only(top: 10.0),
            height: 0.5,
            color: Colors.grey[300],
          ),*/
        ],
      ),
    );
  }

/*  Widget _centerButtons() {
    return Container(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(
                    Icons.grid_on,
                    size: 30.0,
                  ),
                  onPressed: () {}),
              new IconButton(
                  icon: new Icon(
                    Icons.search,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/search');
                  }),
              new IconButton(
                  icon: new Icon(
                    Icons.feedback,
                    size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/feed');
                  }),
              new IconButton(
                  icon: new Icon(
                    Icons.bookmark_border,
                    size: 30.0,
                  ),
                  onPressed: () {}),
            ],
          ),
          new Container(
            height: 0.5,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }*/

  Future<void> x(String id) async {
    liste = await dblocator.fotopost(id);
  }

  Widget _displayImages() {
    UserModel se = Provider.of<UserModel>(context);

    if (flag == true) {
      setState(() {
        var id = se.user.userID;
        if (id != null) {
          debugPrint("fotolar okunutor");
          x(id);
          flag = false;
        }
        // Here you can write your code for open new view
      });
    }

    return Flexible(
        child: new Container(
      child: new GridView.builder(
          itemCount: liste == null ? 0 : liste.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CommentPage(
                        username: se.user.userName,
                        /*  snapshot
                                                                  .data[index]
                                                                  .userName,*/
                        url: liste[index])));
              },
              child: new Container(
                margin: EdgeInsets.all(2.0),
                color: Colors.grey,
                child: Image.network(
                  liste[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    ));
  }
}
