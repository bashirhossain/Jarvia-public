import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jarvia_prime/utilities/data_classes/tasks.dart';
import 'package:flutter/material.dart';

class Writer{
  static Map<MaterialColor, String> _colorMap = {
    Colors.deepOrange: "DeepOrange",
    Colors.lightGreen: "LightGreen",
    Colors.blueGrey: "BlueGrey",
    Colors.purple: "Purple",
  };
  static Map<String, dynamic> allTasksList = {
    "Quadrant 1":<Task>[],
    "Quadrant 2":<Task>[],
    "Quadrant 3":<Task>[],
    "Quadrant 4":<Task>[],
  };
  static Map<String, dynamic> allTasks = {};

  static void clearCache(){
    allTasksList = {
      "Quadrant 1":<Task>[],
      "Quadrant 2":<Task>[],
      "Quadrant 3":<Task>[],
      "Quadrant 4":<Task>[],
    };
  }
  static void mappingFromList(List<Task> newTaskList){
    clearCache();
    for(Task task in newTaskList){
      allTasksList["${task.quadrant}"].add(task);
    }
  }

  static void formatTaskList(List<Task> newTaskList){
    mappingFromList(newTaskList);

    allTasksList.forEach((currentQuadrant, taskList){
      allTasks["$currentQuadrant"] = <String,dynamic>{
        "totalHours": 0,
      };
      double totalTime = 0;
      for(Task task in taskList){
        if(!allTasks["$currentQuadrant"].containsKey(task.eventName)) {
          allTasks["$currentQuadrant"]["${task.eventName}"] = <String, dynamic>{
            "Title": task.eventName,
            "instances": []
          };
        }else{
          int key = 0;
          for(var x in allTasks["$currentQuadrant"]["${task.eventName}"]["instances"]){
            if(x["from"]==task.from){
              key = 1;
              break;
            }
          }
          if(key == 1){
            continue;
          }
        }
        DateTime from = task.from;
        DateTime to = task.to;
        Color background = task.background;
        bool isAllDay = task.isAllDay;
        String quadrant = task.quadrant;
        String description = task.description;

        Map<String, dynamic> instance = {
          "from": from,
          "to":to,
          "color": _colorMap[background],
          "isAllDay": isAllDay,
          "quadrant": quadrant,
          "description": description,
        };

        allTasks["$currentQuadrant"]["${task.eventName}"]["instances"].add(instance);
        totalTime+=to.millisecondsSinceEpoch - from.millisecondsSinceEpoch;
      }
      totalTime = totalTime/3600000;
      allTasks["$currentQuadrant"]["totalHours"] = totalTime;
    });
    upQuadrant1();
    upQuadrant2();
    upQuadrant3();
    upQuadrant4();
  }

  static CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  static Future<void> upQuadrant1() {
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 1': allTasks["Quadrant 1"]})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  static Future<void> upQuadrant2() {
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 2': allTasks["Quadrant 2"]})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  static Future<void> upQuadrant3() {
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 3': allTasks["Quadrant 3"]})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  static Future<void> upQuadrant4() {
    return tasks
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'Quadrant 4': allTasks["Quadrant 4"]})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}