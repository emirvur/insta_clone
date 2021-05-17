import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta/locator.dart';
import 'package:insta/model/user.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/ui/commentpage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OtherProfile extends StatefulWidget {
  final String username;
  OtherProfile({@required this.username});

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  List liste;
  User userr;
  String j;
  bool bolll = false;
  bool flag = true;

  y() {
    dblocator.useridgetirotherprofile(widget.username).then((value) {
      j = value;
      debugPrint("((((((((((((((((((((((((((${j}");
      dblocator.userolustur(value).then((c) {
        userr = c;
        debugPrint("xdddd${userr.bio}");
      });

      //    setState(() {
      //    debugPrint("££££££££££££££££££££");
      // });
    });
  }

  Future<void> userolustur(String b) async {
    userr = await dblocator.userolustur(b);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    y();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        // Here you can write your code for open new view
      });
    });

    //userolustur(j);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (flag == true) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          flag = false;
          // Here you can write your code for open new view
        });
      });
    }

    debugPrint("'''''''^^");
    debugPrint("!!!!!!!!!!!!!!!!!!!fffff!${widget.username}");
    // debugPrint("????????????????????????????${userr.userID}");
    // userolustur(j);
    //debugPrint("heryyyyyyyyyyyy/////////////${j}");
    // debugPrint("heryyyyyyyyyyyy/////////////${userr.followers}");

    return userr == null
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
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

            body: new Column(
              children: <Widget>[_appBar(), _profile(), _displayImages()],
            ),
          );
  }

  Widget _appBar() {
    debugPrint("??????????");
    return new Container(
      color: Colors.black,
      padding: new EdgeInsets.only(top: 25.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: new EdgeInsets.only(left: 10.0),
                child: new Text(
                  "", // widget.username,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              /*  new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.update),
                      iconSize: 25.0,
                      onPressed: () {}),
                  new IconButton(
                      icon: new Icon(Icons.person_add),
                      iconSize: 25.0,
                      onPressed: () {}),
                  new IconButton(
                      icon: new Icon(Icons.format_list_bulleted),
                      iconSize: 25.0,
                      onPressed: () {}),
                ],
              )*/
            ],
          ),
          new Container(
            margin: new EdgeInsets.only(top: 2.0),
            height: 1.5,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Widget _post() {
    debugPrint("()))))))))");
    return new GestureDetector(
      child: new Column(
        children: <Widget>[
          new Text(
            userr == null ? "ss" : userr.posts.toString(),
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
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
    debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!!fdd");
    return new Container(
      margin: new EdgeInsets.only(left: 10.0),
      child: new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Text(
              userr == null ? "qq" : userr.followers.toString(),
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
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
    debugPrint("!!!!!!!!!!!!!!!!!!!!!!!!!hhhhhhhhhhhhhh");
    return new Container(
      //  margin: new EdgeInsets.only(left: 5.0),
      child: new GestureDetector(
        child: new Column(
          children: <Widget>[
            new Text(
              userr == null ? "rr" : userr.followings.toString(),
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 1.0),
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

    dblocator.takipcimi(ser.user.userID, userr.userID).then((value) {
      bolll = value;
    });
    return new Container(
      height: 150.0,
      //  margin: new EdgeInsets.only(top: 5.0),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Image.network(
                        'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DK_M655e4gIo&psig=AOvVaw18QJOpmgZggF_MY2zTjbi2&ust=1594323388624000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMjFj9OzvuoCFQAAAAAdAAAAABAI'
                        //     userr.profilURL == null
                        //        ? 'https://www.google.com/url?sa=i&url=https%3A%2F%2Ftr.pinterest.com%2Fpin%2F846747167415809789%2F&psig=AOvVaw18QJOpmgZggF_MY2zTjbi2&ust=1594323388624000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMjFj9OzvuoCFQAAAAAdAAAAABAD'
                        //           : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DK_M655e4gIo&psig=AOvVaw18QJOpmgZggF_MY2zTjbi2&ust=1594323388624000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMjFj9OzvuoCFQAAAAAdAAAAABAI', //ser.user.profilURL,
                        //     height: 100.0,
                        ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                    alignment: Alignment.bottomLeft,
                    child: new Text(
                      widget.username,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                        height: 60.0,
                        width: 200.0,
                        child: new Text(
                          bolll ? "takipten çık" : "takip et ",
                          style: new TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        if (bolll) {
                          debugPrint("/////////////elsecalisiyor");
                          UserModel us =
                              Provider.of<UserModel>(context, listen: false);

                          us.currentUser().then((value) async {
                            String currentuid = us.user.userID;
                            debugPrint("%%%%%%%%%%%%%%%%%%${us.user.bio}");

                            await dblocator.takibibirak(
                                currentuid, userr.userID);
                            await dblocator.kimtakipediyorbirak(
                                userr.userID, currentuid);
                            bolll = false;
                            debugPrint("bolll false oldu");
                          });

                          setState(() {
                            Navigator.of(context).pop();
                          });
                        } else {
                          debugPrint(
                              "!!!!!!!!!!!!!!!!!!takipet on tap calısnmaya basladı");
                          debugPrint("/////////////ifcalisiyor");
                          UserModel us =
                              Provider.of<UserModel>(context, listen: false);

                          us.currentUser().then((value) async {
                            String currentuid = us.user.userID;
                            debugPrint("%%%%%%%%%%%%%%%%%%${us.user.bio}");
                            await dblocator.takipciol(currentuid, userr.userID);
                            await dblocator.kimtakipediyor(
                                userr.userID, currentuid, us.user.userName);
                            bolll = true;
                            debugPrint("bolll true oldu");
                          });
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          new Container(
            margin: new EdgeInsets.only(top: 10.0),
            height: 0.5,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }

  Future<void> x(String id) async {
    liste = await dblocator.fotopost(id);
  }

  Widget _displayImages() {
    UserModel use = Provider.of<UserModel>(context, listen: false);

    var id = userr.userID;
    if (id != null) {
      x(id);
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
                        username: use.user.userName,
                        /*  snapshot
                                                                  .data[index]
                                                                  .userName,*/
                        url: liste[index])));
              },
              child: new Container(
                margin: EdgeInsets.all(2.0),
                color: Colors.grey,
                child: Image.network(liste[index]),
              ),
            );
          }),
    ));
  }
}
