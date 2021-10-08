import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarvia_prime/Firebase-Interaction/Read/read.dart';
class User{
  String? displayName = FirebaseAuth.instance.currentUser!.displayName;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? userId = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  CollectionReference todo = FirebaseFirestore.instance.collection('todo');
  CollectionReference record = FirebaseFirestore.instance.collection('record');
  User(){
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(userId).get()
        .then((DocumentSnapshot docSnapshot){
      if(!docSnapshot.exists){
        this.addUser();
      }
    });
  }
  void addUser(){
    addTasks();
    addTodo();
    addRecord();
  }

  Future<void> addTasks(){
    return tasks
        .doc(userId)
        .set({
      "Quadrant 1":{
        "totalHours": 0,
      },
      "Quadrant 2":{
        "totalHours": 0,
      },
      "Quadrant 3":{
        "totalHours": 0,
      },
      "Quadrant 4":{
        "totalHours": 0,
      },
    })
        .then((value) => print("User Tasks Added"))
        .catchError((error) => print("Failed to Add user tasks: $error"));
  }
  Future<void> addTodo(){
    return todo
        .doc(userId)
        .set({
      "todolist": {},
    })
        .then((value) => print("User Todo Added"))
        .catchError((error) => print("Failed to Add user todo: $error"));
  }
  Future<void> addRecord(){
    return record
        .doc(userId)
        .set({
      "weekrecords":<Map<String, dynamic>>[],
    })
        .then((value) => print("User Records Added"))
        .catchError((error) => print("Failed to Add user records: $error"));
  }
}