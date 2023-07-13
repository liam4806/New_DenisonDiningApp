// firestore Api file (Update and Read only, need to add erase, eraseAll)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbtoDart extends ChangeNotifier {
  //Load Database
  List<String> imageName = [];
  int itemNum = 0;

  final dataCollection = FirebaseFirestore.instance
      .collection('daily-menu'); //data collection for dining menu

  final confCollection = FirebaseFirestore.instance
      .collection('Configuration'); // data collection for configuration

  Future<QuerySnapshot> read(String name, String timeslot) {
    // data read for dining menu
    return dataCollection.doc(name).collection(timeslot).get();
  }

  Future<QuerySnapshot> readconf() {
    //doc().get return future<documentsnapshot>
    // data read for configuration
    return confCollection.get(); // returns Map(item_num)
  }

  void update(String docId, String hallName, String bld, int loveCount,
      bool isPressed) async {
    if (isPressed == true) {
      // heart icon is activated
      await dataCollection.doc(hallName).collection(bld).doc(docId).update({
        'Like': loveCount + 1,
      });
      notifyListeners(); // notify the main object to refresh data on the page
    } else {
      // heart icon is deactivated
      await dataCollection.doc(hallName).collection(bld).doc(docId).update({
        'Like': loveCount - 1,
      });
      notifyListeners(); // notify the main object to refresh data on the page
    }
  }

  void updateConfFrontImage(String docId, int curItemNum, bool isAdd) async {
    // Update the configuration for front image
    // docId: name of the document
    // isAdd: true or false if the update is adding or deleting an image
    if (isAdd == true) {
      //image is added
      await confCollection.doc(docId).update({'item_num': curItemNum + 1});
      notifyListeners(); // notify the main object to refresh data on the page
    } else {
      // image is deleted
      await confCollection.doc(docId).update({'item_num': curItemNum - 1});
      notifyListeners(); // notify the main object to refresh data on the page
    }
  }

  List<String> stringToList(String input) {
    // Eliminate line space (Can be used to read excel file)
    return input.split('\n');
  }
}
