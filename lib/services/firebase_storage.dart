import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  StorageReference _storageReference;

  Future<String> uploadFile(String userID, File yuklenecekDosya) async {
    _storageReference = _firebaseStorage
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    //   .child("post_${userID}.jpeg"); //.child("profil_foto.png");
    var uploadTask = _storageReference.putFile(yuklenecekDosya);

    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    return url;
  }
}
