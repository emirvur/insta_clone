import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta/locator.dart';
import 'package:insta/ui/UploadPage.dart';
import 'package:insta/ui/splashscreen.dart';
import 'package:insta/ui/editprofile.dart';
import 'package:insta/ui/feedpage.dart';
import 'package:insta/ui/home.dart';
import 'package:insta/ui/otherprofile.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/ui/searchpage.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/ui/signup.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

// First put json file in android and json
// use gradle in android plugin
// yaml for firebase

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
        create: (context) => (UserModel()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase Loogin',
          theme: ThemeData(),
          home: SignIn(),
          routes: {
            '/home': (BuildContext context) => Home(),
            '/signin': (BuildContext context) => SignIn(),
            '/signup': (BuildContext context) => SignUp(),
            '/profile': (BuildContext context) => ProfilePage(),
            '/editprofile': (BuildContext context) => EditProfile(),
            '/upload': (BuildContext context) => UploadPage(),
            '/search': (BuildContext context) => SearchPage(),
            '/feed': (BuildContext context) => FeedPage(),
            '/splash': (BuildContext context) => SplashScreen(),
            //  '/comment': (BuildContext context) => CommentPage(),
            //'/otherprofile': (BuildContext context) => OtherProfile(),
          },
        ));
  }
}

/*
import 'package:flutter/material.dart';
import 'package:insta/locator.dart';
import 'package:insta/ui/editprofile.dart';
import 'package:insta/ui/emailloginpage.dart';
import 'package:insta/ui/landing_page.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/viewmodel/usermodel.dart';
import 'package:provider/provider.dart';


void main() { 
  setupLocator();
  runApp(App());}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>(UserModel()),
          child: MaterialApp(
            routes:{
                '/Profile': (context) => ProfilePage(),
                 '/EditProfile': (context) => EditProfile(),
                  '/Signin': (context) => SignInPage(),
                   '/emaillogin': (context) => EmailveSifreLoginPage(),
                     '/signout': (context) => LandingPage(),
            } ,
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
        
      ),
    );
  }
}

/*class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pages = [
    Feed(),
    Feed(),
    Feed(),
    Feed(),
    Feed(),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFEEEEEE),
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.camera,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.tv,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (i){
          setState(() {
            currentPage = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Feed")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.crop_square),
            title: Text("Upload")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_very_satisfied),
            title: Text("Likes")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            title: Text("Account")
          ),
        ],
      ),
    );
  }
}
*/  */
