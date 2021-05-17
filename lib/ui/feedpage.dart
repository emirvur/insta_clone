import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta/locator.dart';
import 'package:insta/model/post.dart';
import 'package:insta/model/user.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/ui/commentpage.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  final FlareControls flareControls = FlareControls();
  bool isLiked = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreDBService dblocator = locator<FirestoreDBService>();

  User user;
  Future<List<Post>> posts;

  Future<List<Post>> feeddoldur(String useridi) async {
    // setState(() {});
    return dblocator.feeddoldur(useridi);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureı buradan cagir
    //UserModel uuser = Provider.of<UserModel>(context);

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        // Here you can write your code for open new view
      });
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      posts = feeddoldur(user.userID);
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserModel uuser = Provider.of<UserModel>(context);
    user = uuser.user;

    return Scaffold(
      appBar: new AppBar(
          brightness: Brightness.light,
          elevation: 0.4,
          backgroundColor: Colors.white,
          bottom: _appBar()),
      body: _body(),
    );
  }

  Widget _appBar() {
    return new PreferredSize(
        child: new Container(
          color: Colors.white,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.photo_camera),
                iconSize: 25.0,
                onPressed: () {
                  Navigator.pushNamed(context, '/upload');
                },
              ),
              new Text(
                'Insta',
                style: new TextStyle(
                    //   fontFamily: 'Billabong',
                    fontSize: 30.0,
                    color: Colors.black),
              ),
              new IconButton(
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
        ),
        preferredSize: null);
  }

  Widget _listView() {
    return FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Text("ERROR: ${snapshot.error}");
          else if (!snapshot.hasData) {
            return Container(
                color: Colors.amber,
                child: Text(
                    "ah be garibim ${user.userName} arkadaşım hiç mi yok arkadaşın git birilerini ara"));
          } else {
            return Container(
              child: new Flexible(
                  child: new ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data[0].userID == "aaa") {
                          return Container(
                            color: Colors.red,
                            child: Text(
                                "ah be garibim hiç mi yok arkadaşın git birilerini ara"),
                          );
                        }
                        //   debugPrint(snapshot.data[index].fotoURL);
                        return new Container(
                          child: new Container(
                            color: Colors.white,
                            height: 390.0,
                            child: new Column(
                              children: <Widget>[
                                //  _titleFriendAcc(index,snapshot),
                                Container(
                                    margin: EdgeInsets.all(8.0),
                                    child: new Row(
                                      children: <Widget>[
                                        /* new Image.network(
            "https://i.picsum.photos/id/407/200/300.jpg?hmac=2o7TUioGmzxVywnGxQPp4rBF-rDgT9d5Q3QtpEGlDwI",
            height: 40.0,
          ),*/
                                        new Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: new Text(
                                            snapshot.data[index].userName,
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500),
                                          ),

                                          //user.userID == null           ? "r"              : user.userID), // ser.user == null ? "e" : ser.user.userName),
                                        ),
                                      ],
                                    )),
                                //  _listImage(),
                                GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        dblocator.likecontrol(
                                            user.userID,
                                            snapshot.data[index].fotoURL,
                                            user.userName,
                                            snapshot.data[index].userName);
                                        flareControls.play("like");
                                        snapshot.data[index].isliked =
                                            !snapshot.data[index].isliked;

                                        //  isLiked = !isLiked;
                                      });
                                    },
                                    child: Stack(children: <Widget>[
                                      Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: new Image.network(
                                          snapshot.data[index].fotoURL,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                          width: double.infinity,
                                          height: 200,
                                          child: Center(
                                            child: SizedBox(
                                              width: 80,
                                              height: 80,
                                              child: FlareActor(
                                                'assets/images/instagram_like.flr',
                                                controller: flareControls,
                                                animation: 'idle',
                                              ),
                                            ),
                                          ))
                                    ])),

                                // _listBottom(),
                                Container(
                                    //   margin: EdgeInsets.all(8.0),
                                    child: IconButton(
                                  iconSize: 30,
                                  icon: Icon(snapshot.data[index].isliked
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                  onPressed: () {},
                                  color: Colors.red,
                                )),

                                //  _listBottomDate()
                                Container(
                                  margin: EdgeInsets.only(left: 10.0, top: 5.0),
                                  child: new Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          //       new Container(
                                          //       alignment: Alignment.bottomLeft,
                                          //     child: new Text("852 Likes"),
                                          // ),

                                          SizedBox(
                                            width: 30,
                                          ),
                                          new Container(
                                            alignment: Alignment.bottomLeft,
                                            child: new Text(
                                                "Açıklama: ${snapshot.data[index].description}"),
                                          ),
                                        ],
                                      ),
                                      new Container(
                                        margin: EdgeInsets.only(top: 2.0),
                                        alignment: Alignment.bottomLeft,
                                        child:

                                            /*Text(
                                            "July 15",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0),
                                          )*/

                                            snapshot.data[index].createdAt ==
                                                    null
                                                ? Text(
                                                    "July 15",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12.0),
                                                  )
                                                : Text(
                                                    "Yüklenme tarihi: ${snapshot.data[index].createdAt.toString()}"),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CommentPage(
                                                          username:
                                                              user.userName,
                                                          /*  snapshot
                                                                  .data[index]
                                                                  .userName,*/
                                                          url: snapshot
                                                              .data[index]
                                                              .fotoURL)));
                                        },
                                        child: Text(
                                          "Yorum yapmak veya tüm yorumları görmek için tıklayınız",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })),
            );
          }
        });
  }

  Widget _body() {
    return posts == null
        ? CircularProgressIndicator()
        : Container(
            child: new Column(
              children: <Widget>[_listView()],
            ),
          );
  }
}

/*Widget _floatPic() {
    return Container(
      height: 100.0,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 21,
                  itemBuilder: (BuildContext context, int index) {
                    return new Container(
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.all(10.0),
                            child: new Image.network(
                              (index == 0)
                                  ? 'https://picsum.photos/250?image=9'
                                  : 'https://i.picsum.photos/id/407/200/300.jpg?hmac=2o7TUioGmzxVywnGxQPp4rBF-rDgT9d5Q3QtpEGlDwI',
                              height: 60.0,
                            ),
                          ),
                          new Text((index == 0) ? "You" : " Friend ")
                        ],
                      ),
                    );
                  })),
          new Container(
            height: 0.5,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }*/

/* Widget _titleFriendAcc(int i, AsyncSnapshot snap) {
    UserModel ser = Provider.of<UserModel>(context);
    return new Container(
      margin: EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          /* new Image.network(
            "https://i.picsum.photos/id/407/200/300.jpg?hmac=2o7TUioGmzxVywnGxQPp4rBF-rDgT9d5Q3QtpEGlDwI",
            height: 40.0,
          ),*/
          new Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: new Text(snap.data[index]),

            //user.userID == null           ? "r"              : user.userID), // ser.user == null ? "e" : ser.user.userName),
          ),
        ],
      ),
    );
  }*/

/* Widget _listImage() {
    return Container(
      child: new Image.network(
        "https://i.picsum.photos/id/407/200/300.jpg?hmac=2o7TUioGmzxVywnGxQPp4rBF-rDgT9d5Q3QtpEGlDwI",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _listBottom() {
    return new Container(
      margin: EdgeInsets.all(8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Icon(Icons.favorite_border, size: 30.0),
              new Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: new Icon(Icons.receipt, size: 30.0),
              ),
              new Icon(Icons.near_me, size: 30.0),
            ],
          ),
          new Icon(
            Icons.bookmark_border,
            size: 30.0,
          ),
        ],
      ),
    );
  }

  Widget _listBottomDate() {
    return new Container(
      margin: EdgeInsets.only(left: 10.0, top: 5.0),
      child: new Column(
        children: <Widget>[
          new Container(
            alignment: Alignment.bottomLeft,
            child: new Text("852 Likes"),
          ),
          new Container(
            margin: EdgeInsets.only(top: 2.0),
            alignment: Alignment.bottomLeft,
            child: new Text(
              "July 15",
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }*/
