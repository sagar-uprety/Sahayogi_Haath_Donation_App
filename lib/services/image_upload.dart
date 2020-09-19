import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class CloudPath {
  static const String profile = 'profile';
  static const String document = 'documents';
  static const String activities = 'activities';
  static const String org_banner = 'org_banners';
}

class ImageUploader {
  Future<String> uploadImage(
      {@required File image,
      @required String path,
      @required String id}) async {
    final ref = FirebaseStorage.instance.ref().child(path).child(id + '.jpg');

    await ref.putFile(image).onComplete;
    String url = await ref.getDownloadURL();
    print(url);
    return url;
  }

  Future<void> deleteImage({@required String path, @required String id}) async {
    final ref = FirebaseStorage.instance.ref().child(path).child(id + '.jpg');

    await ref.delete().then((value) {
      print('Successfully Deleted');
    }).catchError((e) {
      print('Error Deleting the File');
      print(e);
    });
  }
}

class ConvertUrl {
  Future<File> urlToFile(String imageUrl) async {
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(imageUrl);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }
}
