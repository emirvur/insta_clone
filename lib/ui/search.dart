/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/ui/otherprofile.dart';

class Search extends SearchDelegate {
  Firestore dblocator = Firestore.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //UserModel userr = Provider.of<UserModel>(context);

    List suggestionList = query.isEmpty
        ? []
        : dblocator
            .collection("users")
            .where('userName', isEqualTo: query)
            .snapshots()
            .listen((event) {
            event.documents.map((e) => e.data['userName']).toList();
          });

    ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                //   suggestionList.length == 0       ? Container()             :
                suggestionList[index]),
            onTap: () {
              debugPrint("!!!!!!search on tap basladı");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherProfile(
                          username: suggestionList[index],
                        )),
              );
            },
          );

          /*GestureDetector(
            child: Card(
              child: Container(
                height: 130,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            suggestionList.length == 0
                                ? Container()
                                : suggestionList[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              debugPrint("!!!!!!search on tap basladı");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherProfile(
                          username: suggestionList[index],
                        )),
              );
            },
          );*/
        });
  }
}
*/
