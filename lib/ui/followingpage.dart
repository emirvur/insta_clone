import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta/locator.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  List liste = [];
  String y;
  bool b = false;

  listedoldur() async {
    liste = await dblocator.takipliste(y);

    setState(() {
      b = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      listedoldur();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context, listen: true);
    y = user.user.userID;
    return Scaffold(
        body: b == false
            ? CircularProgressIndicator()
            : Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                child: new ListView.builder(
                    itemCount: liste.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (liste[0] == 0) {
                        return Container(
                            color: Colors.red,
                            child: Text("seni kimsecikler takip etmiyor :(("));
                      }
                      return new Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Text("${liste[index]} seni takip ediyor"),
                            ],
                          ));
                    })));
  }
}
