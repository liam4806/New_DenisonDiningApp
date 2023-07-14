import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  String downloadURL = '';
  List<String> Urls = []; //Stores All results from getDowloadURL()

  Future<void> downloadURLExample(int index) async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child('image' + index.toString() + '.png')
        .getDownloadURL();
    Urls.add(downloadURL);
    //debugPrint(downloadURL.toString());
  }

  Future<List<String>> getData(int item_num) async {
    try {
      for (var i = 1; i < item_num + 1; i++) await downloadURLExample(i);

      return Urls;
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
}
