import 'package:flutter/material.dart';
import 'package:insta/locator.dart';
import 'package:insta/services/firestore_db_Service.dart';

class CommentPage extends StatefulWidget {
  final String username;
  final String url;
  CommentPage({@required this.url, @required this.username});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _controllercomment;
  String comment;
  FirestoreDBService dblocator = locator<FirestoreDBService>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List usernamecomment;
  List comments;

  Future<void> commentoku(String fotourl) async {
    comments = await dblocator.commentoku(fotourl);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentoku(widget.url).then((value) {
      setState(() {});
    });
    _controllercomment = TextEditingController();
  }

  @override
  void dispose() {
    _controllercomment.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //  setState(() {
    //    commentoku(widget.url);
    //  });
    return Scaffold(
        //   resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Yorumlar"),
        ),
        body: comments == null
            ? CircularProgressIndicator()
            : Column(
                //eger yorumlar tasarsa ne olacak singular childscroll kullan istersen
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: Text(comments[i].comment),
                          subtitle: Text(
                            comments[i].userName,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(Icons.send),
                                    onTap: () {
                                      _formKey.currentState.save();
                                      dblocator.commentata(
                                          comment, widget.username, widget.url);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  hintText: 'yorum yap',
                                  labelText: 'yorum yap',
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (String girilen) {
                                  comment = girilen;
                                },
                              ),
                            ),
                            /*    IconButton(
                                icon: Icon(Icons.send),
                                onPressed: () {
                                  _formKey.currentState.save();
                                  dblocator.commentata(
                                      comment, widget.username, widget.url);
                                  Navigator.of(context).pop();
                                })*/
                          ],
                        )),
                  )
                ],
              )

        /*
         SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 150,
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.comment),
                            hintText: 'yorum',
                            labelText: 'yorum',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (String girilen) {
                            comment = girilen;
                          },
                        ),
                        IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              _formKey.currentState.save();
                              dblocator.commentata(
                                  comment, widget.username, widget.url);
                              Navigator.of(context).pop();
                            })
                      ],
                    )),
              ),
              Text("dd"),
              comments == null
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          leading: Text(usernamecomment[i]),
                          title: Text(comments[i]),
                        );
                      },
                    )
            ],
          ),
        )
        */

        );
  }
}
