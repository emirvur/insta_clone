import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta/locator.dart';
import 'package:insta/model/like.dart';
import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class YouPage extends StatefulWidget {
  @override
  _YouPageState createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> {
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  List<Like> liste = [];
  String y;
  bool b = false;

  listedoldur() async {
    liste = await dblocator.likedoldur(y);

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
    y = user.user.userName;
    return Scaffold(
        body: b == false
            ? CircularProgressIndicator()
            : Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                child: new ListView.builder(
                    itemCount: liste.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (liste[0].fotourl == "") {
                        return Container(
                            color: Colors.red,
                            child: Text(
                                "${y} kimse seni begenmemis fotolarını guzellestir"));
                      }
                      return new Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              liste[index].like
                                  ? Row(
                                      children: <Widget>[
                                        Text(
                                            "${liste[index].takipciad} senin fotonu begendi"),
                                        Container(
                                          height: 36.0,
                                          width: 36.0,
                                          child: Image.network(
                                            liste[index].fotourl,
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                      ],
                                    )
                                  : Text(""),
                            ],
                          ));
                    })));
  }
}
