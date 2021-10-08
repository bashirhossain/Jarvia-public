import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllWeekReader{
  static List<dynamic> allWeekRecords = [];

  static Future<int> getLastUpdateDate() async{
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    int lastDate = 0;
    Map<String, dynamic> readDoc = {};
    await FirebaseFirestore
        .instance
        .collection('record')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        readDoc = documentSnapshot.data() as Map<String,dynamic>;
        lastDate = readDoc["lastDate"];
      }
    });
    return lastDate;

  }

  static Future<List<dynamic>> getAllWeekRecords() async{
    Map<String, dynamic> readDoc = {};
    allWeekRecords = [];
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore
        .instance
        .collection('record')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        readDoc = documentSnapshot.data() as Map<String,dynamic>;
        allWeekRecords = readDoc["weekrecords"];
      }
    });
    if(allWeekRecords.isEmpty){
      allWeekRecords = [];
      return allWeekRecords;
    }
    return allWeekRecords;
  }
}
