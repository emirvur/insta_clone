import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/locator.dart';
import 'package:insta/model/post.dart';
import 'package:insta/model/user.dart';
import 'package:insta/services/firebase_storage.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:insta/services/firestore_db_Service.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin {
  FirebaseStorageService strlocator = locator<FirebaseStorageService>();
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  PickedFile _profilFoto;
  String url;
  String description;
  TextEditingController controller;
  File file;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _kameradanFotoCek() async {
    PickedFile _yeniResim =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 40);

    setState(() {
      _profilFoto = _yeniResim;
      Navigator.of(context).pop();
    });
  }

  void _galeridenResimSec() async {
    PickedFile _yeniResim =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _profilFoto = _yeniResim;
      debugPrint("galeriden!!!!!!!sıkınıt");
      Navigator.of(context).pop();
    });
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(child: Text("Fotoğraf gönderme")),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  UserModel userr =
                      Provider.of<UserModel>(context, listen: false);
                  await userr.currentUser();
                  User user = userr.user;
                  if (_profilFoto == null) {
                    debugPrint("olazzz dsoya bas00");
                    return;
                  }
                  file = File(_profilFoto.path);
                  /*   if (file != null) {
                setState(() {
                  base64Encode(file.readAsBytesSync());
                  //print(base64Encode(file.readAsBytesSync()));
                });
              }*/
                  /* compress() async {
                    final t = await getTemporaryDirectory();
                    final p = t.path;
                  ImD.Image
                  }*/

                  url = await strlocator.uploadFile(user.userID, file);
                  debugPrint(user.userName);
                  await dblocator.postgonder(
                      user.userID, user.userName, url, description);
                  debugPrint("^^^^^feedtakipc basliyor");

                  await dblocator.feedtakipcilere(
                      user.userID,
                      Post(
                          userID: user.userID,
                          userName: user.userName,
                          fotoURL: url,
                          description: description));

                  debugPrint("^^^^^feedtakipc bitti");

                  setState(() {
                    //       Navigator.push(
                    //       context,
                    //     MaterialPageRoute(builder: (context) => ProfilePage()),
                    // );

                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 60,
                            child: Text("başarıyla postunuz gönderildi"),
                          );
                        });
                  });
                },
              ),
              Text("Gönder"),
              IconButton(
                icon: Icon(Icons.photo),

                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            height: 160,
                            child: Column(children: <Widget>[
                              TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'açıklama gir'),
                                onChanged: (str) {
                                  description = str;
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.camera),
                                title: Text("Kameradan Çek"),
                                onTap: () {
                                  _kameradanFotoCek();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text("Galeriden Seç"),
                                onTap: () {
                                  _galeridenResimSec();
                                },
                              ),
                            ]));
                      });
                },
                // padding: const EdgeInsets.all(8.0),
                /*   child: GestureDetector(onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      height: 160,
                      child: Column(children: <Widget>[
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'description gir'),
                          onChanged: (str) {
                            description = str;
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text("Kameradan Çek"),
                          onTap: () {
                            _kameradanFotoCek();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.image),
                          title: Text("Galeriden Seç"),
                          onTap: () {
                            _galeridenResimSec();
                          },
                        ),
                      ]));
                });
          }) */
              ),
              Text("fotoğrafı seç")
            ]))));
  }
}
