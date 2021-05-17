import 'package:flutter/material.dart';
import 'package:insta/ui/profilepage.dart';
import 'package:insta/ui/search.dart';
import 'package:insta/ui/otherprofile.dart';
import 'package:insta/locator.dart';
import 'package:insta/searchservice.dart';
import 'package:insta/ui/signinpage.dart';
import 'package:insta/ui/signup.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  SearchService search = locator<SearchService>();
  var txtcont = TextEditingController();

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [
          {'userName': "emirhan"},
          {'userName': "ercan"},
        ];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toLowerCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      search.searchByName(value).then((var docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
      setState(() {
        debugPrint("!!!!!!!!!!!!!!!!");
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['userName'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    txtcont.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          controller: txtcont,
          decoration: InputDecoration(
              prefixIcon: IconButton(
                color: Colors.black,
                icon: Icon(Icons.clear),
                iconSize: 20.0,
                onPressed: () {
                  txtcont.clear();
                },
              ),
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Başka kullanıcı ara',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        ),
      ),
      SizedBox(height: 10.0),

      /*   ListView.builder(
              itemCount: tempSearchStore.length,
              itemBuilder: (context, index) {
                return ListTile(
                  //    title: tempSearchStore[index],
                  onTap: () {
                    debugPrint("!!!!!!search on tap basladı");
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtherProfile(
                              username: tempSearchStore[index],
                            ),
                          ));
                    });
                  },
                );
              })*/

      GridView.count(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          primary: false,
          shrinkWrap: true,
          children: tempSearchStore.map((element) {
            return GestureDetector(
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 2.0,
                  child: Container(
                      child: Center(
                          child: Row(
                    children: <Widget>[
                      /*    Image.network(
                        element['profilURL'],
                        fit: BoxFit.cover,
                      ),*/
                      Text(
                        element['userName'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  )))),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OtherProfile(
                              username: element['userName'],
                            )));
              },
            );
          }).toList())
    ]));
  }
}

Widget buildResultCard(data) {
  return GestureDetector(
      child: ListTile(
    title: data['userName'],

    /*    child: Container(
            child: Center(
                child: Text(
          data['userName'],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ))))
        */

    onTap: () {},
  ));
}
/*Scaffold(
      appBar: AppBar(
        title: Text("profilleri arayın"),
        backgroundColor: Colors.red.shade500,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          )
        ],
      ),
    )
    ;
  }
}*/
