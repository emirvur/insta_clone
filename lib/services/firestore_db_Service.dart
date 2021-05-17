import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:insta/model/like.dart';
import 'package:insta/model/user.dart';
import 'package:insta/model/post.dart';
import 'package:insta/model/comment.dart';

class FirestoreDBService {
  final Firestore _firebaseDB = Firestore.instance;

  Future<bool> saveUser(User user) async {
    DocumentSnapshot _okunanUser =
        await Firestore.instance.document("users/${user.userID}").get();

    if (_okunanUser.data == null) {
      await _firebaseDB
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());
      return true;
    } else {
      return true;
    }
  }

  Future<User> readUser(String userID) async {
    DocumentSnapshot _okunanUser =
        await _firebaseDB.collection("users").document(userID).get();
    Map<String, dynamic> _okunanUserBilgileriMap = _okunanUser.data;

    User _okunanUserNesnesi = User.fromMap(_okunanUserBilgileriMap);
    //print("Okunan user nesnesi :" + _okunanUserNesnesi.toString());
    return _okunanUserNesnesi;
  }

  Future<void> updateUser(
      String userID, String yeniUserName, String bio) async {
    {
      await _firebaseDB
          .collection("users")
          .document(userID)
          .updateData({'userName': yeniUserName, 'bio': bio});
    }
  }

  @override
  Future<bool> updateProfilFoto(String userID, String profilFotoURL) async {
    await _firebaseDB
        .collection("users")
        .document(userID)
        .updateData({'profilURL': profilFotoURL});
    return true;
  }

  Future<void> postgonder(String userID, String username, String profilFotoURL,
      String description) async {
    Post post = Post(
        userID: userID,
        userName: username,
        fotoURL: profilFotoURL,
        description: description);

    await _firebaseDB
        .collection("posts")
        .document(userID)
        .collection("post")
        .add(post.toMap());

    await _firebaseDB
        .collection("users")
        .document(userID)
        .updateData({'posts': FieldValue.increment(1)});
  }

  Future<List> fotopost(String id) async {
    QuerySnapshot snap = await _firebaseDB
        .collection("posts")
        .document(id)
        .collection("post") //.orderBy()
        .getDocuments();

    return snap.documents.map((e) => e.data['fotoURL']).toList();
  }

  Future useridgetirotherprofile(String username) async {
    QuerySnapshot snap = await _firebaseDB
        .collection("users")
        .where('userName', isEqualTo: username)
        .getDocuments();

    return snap.documents.map((e) => e.data['userID']).toList().first;
  }

  Future<User> userolustur(String b) async {
    DocumentSnapshot doc =
        await _firebaseDB.collection("users").document(b).get();
    User h = User.fromMap(doc.data);
    return h;
  }

  Future<List<Post>> feeddoldur(String useridi) async {
    QuerySnapshot snap = await _firebaseDB
        .collection("feed")
        .document(useridi)
        .collection(useridi)
        .orderBy("createdAt", descending: true)
        //.add(post.toMap());
        .getDocuments();

    if (snap.documents.length == 0) {
      return [Post(userID: "aaa")];
    }

    return snap.documents.map((e) => Post.fromMap(e.data)).toList();
  }

  Future<void> feedtakipcilere(String useridi, Post post) async {
    QuerySnapshot snap = await _firebaseDB
        .collection("kimtakipediyor")
        .document(useridi)
        .collection("takipedenid")
        .getDocuments();
    debugPrint("hememeen calsııt");

    if (snap.documents.length == 0) {
      debugPrint("snap bos gedl");
    } else {
      debugPrint("else calısıyor");
      List takipedenlistesi =
          snap.documents.map((e) => e.data['currentid']).toList();
      // debugPrint("(((((((((((((((((((((${takipedenlistesi[0]}");
      // debugPrint("(((((((((((((((((((((${takipedenlistesi[1]}");

      //  _firebaseDB.collection("feed").document("d") .collection("d").add(post.toMap());
      if (takipedenlistesi.length > 1) {
        for (int i = 0; i < takipedenlistesi.length - 1; i++) {
          await _firebaseDB
              .collection("feed")
              .document(takipedenlistesi[i])
              .collection(takipedenlistesi[i])
              .add(post.toMap());
        }
      } else if (takipedenlistesi.length == 1) {
        await _firebaseDB
            .collection("feed")
            .document(takipedenlistesi[0])
            .collection(takipedenlistesi[0])
            .add(post.toMap());
      } else {}
    }

    /*  takipedenlistesi.map((e) {
      _firebaseDB
          .collection("feed")
          .document(e)
          .collection(e)
          .add(post.toMap());
    });*/
  }

  Future<void> likecontrol(String takipId, String photoURL, String takipciad,
      String fotocuad) async {
    QuerySnapshot x = await _firebaseDB
        .collection("feed")
        .document(takipId)
        .collection(takipId)
        .where('fotoURL', isEqualTo: photoURL)
        .getDocuments();
    debugPrint("^^^^^^^^^^^^^^ilk asama;");
    debugPrint("^^^^^^^^^^^^^uyarrrr;");

    if (x.documents[0].data.isNotEmpty) {
      debugPrint("&&&&&&&&&&&&&&bosssdegikk");
    }

    bool y = x.documents[0].data['isliked'];
    String z = x.documents[0].documentID;

    debugPrint("%%%%%%%%%%%%5ikinci asama");
    if (y == true) {
      await _firebaseDB
          .collection("feed")
          .document(takipId)
          .collection(takipId)
          .document(z)
          .updateData({'isliked': false});

      await _firebaseDB
          .collection("like")
          .document(fotocuad)
          .collection("kimlerlikeatmıs")
          .add({'takipciad': takipciad, 'like': false, 'fotourl': photoURL});
    }
    //debugPrint("&&&&&&&&&&ücüücnd asama");

    else {
      await _firebaseDB
          .collection("feed")
          .document(takipId)
          .collection(takipId)
          .document(z)
          .updateData({'isliked': true});

      await _firebaseDB
          .collection("like")
          .document(fotocuad)
          .collection("kimlerlikeatmıs")
          .add({'takipciad': takipciad, 'like': true, 'fotourl': photoURL});
    }
    debugPrint("//////donrudncu asam");
  }

  Future<List<Like>> likedoldur(String fotoad) async {
    QuerySnapshot list = await _firebaseDB
        .collection("like")
        .document(fotoad)
        .collection("kimlerlikeatmıs")
        .getDocuments();

    if (list.documents.length == 0) {
      return [Like(takipciad: "", fotourl: "", like: true)];
    }
    return list.documents.map((e) => Like.fromMap(e.data)).toList();
  }

  Future<void> takipciol(String currentid, String takipid) async {
    await _firebaseDB
        .collection("takipettigi")
        .document(currentid)
        .collection("okisiudsi")
        .document(takipid)
        .setData({'takipid': takipid});

    await _firebaseDB
        .collection("users")
        .document(currentid)
        .updateData({'followers': FieldValue.increment(1)});

    await _firebaseDB
        .collection("users")
        .document(takipid)
        .updateData({'followings': FieldValue.increment(1)});
  }

  Future<void> kimtakipediyor(
      String takipid, String currentid, String username) async {
    await _firebaseDB
        .collection("kimtakipediyor")
        .document(takipid)
        .collection("takipedenid")
        .document(currentid)
        .setData({'currentid': currentid, 'userName': username});
  }

  Future takipliste(String takipid) async {
    QuerySnapshot x = await _firebaseDB
        .collection("kimtakipediyor")
        .document(takipid)
        .collection("takipedenid")
        .getDocuments();

    if (x.documents.length == 0) {
      return [0];
    }
    return x.documents.map((e) => (e.data['userName'])).toList();
  }

  Future<void> commentata(
      String comment, String userName, String fotoURL) async {
    String x = fotoURL.substring(1, 4);
    await _firebaseDB
        .collection("comments")
        .add({'userName': userName, 'fotoURL': fotoURL, 'comment': comment});
  }

  Future<List> commentoku(String url) async {
    debugPrint("&&&&&&&&&&&&&&&&&girdi fonksina");
    QuerySnapshot snap = await _firebaseDB
        .collection("comments")
        .where('fotoURL', isEqualTo: url)
        .getDocuments();
    debugPrint("111111111111111111111111where isllemini yaptı");

    //  username = snap.documents.map((e) => e.data['userName']).toList();    comment = snap.documents.map((e) => e.data['comment']).toList();
    return snap.documents
        .map((e) => Comment.fromMap(e.data)) //   e.data.['comment'])
        .toList();
  }

  Future<bool> takipcimi(String currentid, String otherid) async {
    QuerySnapshot snap = await _firebaseDB
        .collection("takipettigi")
        .document(currentid)
        .collection("okisiudsi")
        .where('takipid', isEqualTo: otherid)
        .getDocuments();
    if (snap.documents[0].data.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> takibibirak(String currentid, String takipid) async {
    var snap = await _firebaseDB
        .collection("takipettigi")
        .document(currentid)
        .collection("okisiudsi")
        .document(takipid)
        .delete();

    //  .where('takipid', isEqualTo: takipid)
    //    .getDocuments();

    //  snap.documents.first.delete(); // map((e) => e.reference.delete());

    await _firebaseDB
        .collection("users")
        .document(currentid)
        .updateData({'followers': FieldValue.increment(-1)});

    await _firebaseDB
        .collection("users")
        .document(takipid)
        .updateData({'followings': FieldValue.increment(-1)});
  }

  Future<void> kimtakipediyorbirak(String takipid, String currentid) async {
    var sna = await _firebaseDB
        .collection("kimtakipediyor")
        .document(takipid)
        .collection("takipedenid")
        .document(currentid)
        .delete();

    //    .getDocuments();
    //  sna.documents[0].data.clear(); // .map((e) => e.reference.delete());
  }

// comment classı olarak döndür onları obje listeesi future dondursun bu sayede hem username hem comment listtile da kullanabilirsin

}
