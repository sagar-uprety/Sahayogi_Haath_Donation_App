import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CloudPath{
  static const String profile= 'profile';
  static const String document= 'documents';
  static const String activities= 'activities';
}

class ImageUploader{
  Future<String> uploadImage({@required File image, @required String path, @required String userId}) async{
    final ref = FirebaseStorage.instance
          .ref()
          .child(path)
          .child(userId + '.jpg');

    await ref.putFile(image).onComplete;
    String url = await ref.getDownloadURL();
    print(url);
    return url;
  }
}