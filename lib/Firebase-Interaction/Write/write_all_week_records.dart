import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Read/read.dart';
import '../Read/all_week_records.dart';

class AllWeekWriter{
  static Map<String, dynamic> allTasks = {};

  static CollectionReference record = FirebaseFirestore.instance.collection('record');

  static double zero = 0.0;

  static Future<void> updateWeeksRecord() async{
    DateTime rightNow = DateTime.now();
    int now = rightNow.weekday;
    int daysSinceLastUpdate = 0;
    await AllWeekReader.getLastUpdateDate().then(
            (lastDate) => {
          daysSinceLastUpdate = rightNow.day - lastDate
        }
    );
    if(now != 2 || daysSinceLastUpdate<7){

      print("notTime");
      return;
    }
    upWeekData();
  }
  static Future<void> resetQuadrant1() async{
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 1.totalHours': zero})
        .then((value) => print("Quadrant 1 has been reset"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  static Future<void> resetQuadrant2() async{
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 2.totalHours': zero})
        .then((value) => print("Quadrant 2 has been reset"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  static Future<void> resetQuadrant3() async{
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 3.totalHours': zero})
        .then((value) => print("Quadrant 3 has been reset"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  static Future<void> resetQuadrant4() async{
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 4.totalHours': zero})
        .then((value) => print("Quadrant 4 has been reset"))
        .catchError((error) => print("Failed to update user: $error"));

  }
  static Future<void> upWeekData() async {
    Map<String, double> quadrantHours = {};
    await Reader.getQuadrantHours().then(
            (result) => {
              quadrantHours = result
            }
    );

    await resetQuadrant1();
    await resetQuadrant2();
    await resetQuadrant3();
    await resetQuadrant4();

    List<dynamic> allWeekHours = [];
    await AllWeekReader.getAllWeekRecords().then(
            (result) => {
              allWeekHours = result
            }
    );

    DateTime end = DateTime.now();
    DateTime start = DateTime.now().add(const Duration(days: -7));

    int startDate = start.day;
    int endDate = end.day;

    int startMonth = start.month;
    int endMonth = end.month;

    int startYear = start.year;
    int endYear = end.year;

    String thisWeekDate = "$startDate - $startMonth - $startYear to $endDate - $endMonth - $endYear";
    Map<String, Map<String, double>> thisWeek = {
      "$thisWeekDate": quadrantHours,
    };

    allWeekHours.add(thisWeek);
    print(allWeekHours);

    await updateDate(endDate);

    return record
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'weekrecords': allWeekHours})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  static Future<void> updateDate(int today) async{
    return  record
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'lastDate': today})
        .then((value) => print("Update date updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}