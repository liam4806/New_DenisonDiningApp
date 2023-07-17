//Firebase storage Api

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  String downloadURL = '';
  List<String> Urls = []; //Stores All results from getDowloadURL()

  Future<void> downloadURLExample(String image_name) async {
    // Produce download url with given image name and add it to Urls list
    downloadURL =
        await FirebaseStorage.instance.ref().child(image_name).getDownloadURL();
    Urls.add(downloadURL);
  }

  Future<List<String>> getData(
      List<QueryDocumentSnapshot<Object?>> image_names, int item_num) async {
    // Produce download urls with given names from image_names
    // image_names: a String list of image names
    // item_num: the length of image_names
    try {
      //
      for (var i = 0; i < item_num; i++)
        await downloadURLExample(image_names[i].get('name'));

      return Urls;
    } catch (e) {
      debugPrint("Error: $e");
      return [];
    }
  }
}
