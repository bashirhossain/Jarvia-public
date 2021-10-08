import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jarvia_prime/utilities/data_classes/tasks.dart';

class Reader{

  static Map<String, dynamic>? allTasks;

  static List<String> quadrants  = ["Quadrant 1", "Quadrant 2","Quadrant 3","Quadrant 4"];
  static Map<String, dynamic> allTasksList ={};

  static Future<Map<String, double>> getQuadrantHours() async{
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance.collection('tasks').doc(uid).snapshots();
    await FirebaseFirestore
        .instance
        .collection('tasks')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        allTasks = documentSnapshot.data() as Map<String,dynamic>;
      }
    });
    Map<String, double> quadrantHours;
    if(allTasks!=null){
      double q1hrs = allTasks!["Quadrant 1"]["totalHours"];
      double q2hrs = allTasks!["Quadrant 2"]["totalHours"];
      double q3hrs = allTasks!["Quadrant 3"]["totalHours"];
      double q4hrs = allTasks!["Quadrant 4"]["totalHours"];

      quadrantHours = <String, double>{
        "Quadrant 1": q1hrs,
        "Quadrant 2": q2hrs,
        "Quadrant 3": q3hrs,
        "Quadrant 4": q4hrs,
      };
    } else {
      quadrantHours = <String, double>{
        "Quadrant 1": 0,
        "Quadrant 2": 0,
        "Quadrant 3": 0,
        "Quadrant 4": 0,
      };
    }
    return quadrantHours;
  }
  static Future<Map<String, dynamic>> readAllTasks() async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore
        .instance
        .collection('tasks')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        allTasks = documentSnapshot.data() as Map<String,dynamic>;
        formatTasksForCalendar();
      }
    });
    print(allTasksList);
    return allTasksList;
  }

  static void formatTasksForCalendar(){

    for(var taskQuadrant in quadrants){
      Map<String,dynamic> quadrantTasks = allTasks!['$taskQuadrant'];
      List<Task> quadrantsTasks = [];

      quadrantTasks.forEach((task, taskDetails) {
        if(task!="totalHours"){
          List instances = taskDetails["instances"];
          String eventName = taskDetails["Title"];
          DateTime from;
          DateTime to;
          Color background;
          bool isAllDay;
          String quadrant = taskQuadrant;
          String description;
          for(var instance in instances){
            from = DateTime.fromMillisecondsSinceEpoch(instance["from"].seconds*1000);
            to = DateTime.fromMillisecondsSinceEpoch(instance["to"].seconds*1000);
            isAllDay = instance["isAllDay"];
            description = instance["description"];

            quadrantsTasks
                .add(
                Task(
                  eventName: eventName,
                  quadrant: quadrant,
                  from: from,
                  to: to,
                  isAllDay: isAllDay,
                  description: description,
                )
            );
          }
        }
      });
      allTasksList["$taskQuadrant"] = quadrantsTasks;
    }
  }
}
