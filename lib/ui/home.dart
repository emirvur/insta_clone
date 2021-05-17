/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;
  bool isSignedIn = false;
  String imageUrl;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/signin');
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      this.user = firebaseUser;
      this.isSignedIn = true;
      setState(() {
        // Navigator.pushReplacementNamed(context, '/signin');
      });
    }
  }

  signout() async {
    setState(() {
      _auth.signOut();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
          child: !isSignedIn // setting isSignedIn to true
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 80),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(80, 15, 80, 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.blue,
                        onPressed: signout,
                        child: Text(
                          'Log Out',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:insta/model/user.dart';
import 'package:insta/ui/editprofile.dart';
import 'package:insta/ui/feedpage.dart';
import 'package:insta/ui/homepage.dart';
import 'package:insta/ui/landing_page.dart';
import 'package:insta/ui/likepage.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/ui/searchpage.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/ui/signinpage.dart';

import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

import 'UploadPage.dart';

class Home extends StatefulWidget {
//User user;

//Home({@required this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<Widget> _widgets = <Widget>[
    ProfilePage(),
    FeedPage(),
    SearchPage(),
    LikeBottomIconScreen(),
    UploadPage(),
  ];

  PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        // Here you can write your code for open new view
      });
    });
    debugPrint("1!!!!!!initstate");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("!!!!!!!rebuiltttt");
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: _widgets,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.shade300,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("")),
          BottomNavigationBarItem(icon: Icon(Icons.headset), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), title: Text("")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
