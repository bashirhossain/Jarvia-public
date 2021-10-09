import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'TestApp.dart';
import 'main.dart';
import 'question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase.dart';
import 'open.dart';





 List<String> textadd1 =<String>['S/W Lab','Maths'];
final firebaseinstance=FirebaseFirestore.instance;
var today = new DateTime.now();
var addwithtoday= new DateTime.now();





FirebaseAuth auth= FirebaseAuth.instance;


class TestAppState extends State<TestApp>{
  String uid =auth.currentUser!.uid;



  List<String> textadd =<String>['Do laundry'];
  var addquest=0;
  var addquest1=0;
  var flagofflist=0;

  var quest = 0;

  TextEditingController _namecontroller = TextEditingController();



  DateTime currentDate =DateTime.now();

  DateTime pickedDate =DateTime.now();
  TimeOfDay time= TimeOfDay.now();
  TimeOfDay pickedTime= TimeOfDay.now();
  static const routename ='/profile';

  CollectionReference tasklist=FirebaseFirestore.instance.collection('task');
  CollectionReference firebaselistinstance= FirebaseFirestore.instance.collection('items');
  var change_state=0;

  void dismiss(String something){
      DocumentReference users = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Mytask').doc(something);
      DocumentReference quadrant2_doc = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant2').doc(something);

      if(change_state==0)
        users.delete();  //Deletes a task
      else
        quadrant2_doc.delete();


  }

  void checkbox(String documnent,bool? value)async{



      DocumentReference users = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Mytask').doc(documnent);
      DocumentReference quadrant2 = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant2').doc(documnent);
      CollectionReference completed= FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant1_Complete');
      CollectionReference completed_quadrant2= FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant2_Complete');
      DateTime currentDate =DateTime.now();
      Timestamp time= Timestamp.fromDate(currentDate);
      DocumentReference session=FirebaseFirestore.instance.collection("Users").doc(uid).collection("session_time").doc("time");
      DocumentReference q2_snapshot= FirebaseFirestore.instance.collection("Users").doc(uid).collection("session").doc("Quadrant2");
      DocumentReference q1_snapshot =FirebaseFirestore.instance.collection("Users").doc(uid).collection("session").doc("Quadrant1");

      DocumentReference collectquadrant2 = FirebaseFirestore.instance.collection('Users').doc(uid).collection("session").doc('Quadrant2');
      DocumentReference collectquadrant1 = FirebaseFirestore.instance.collection('Users').doc(uid).collection("session").doc('Quadrant1');

      var documentdata=await session.get();
      var documentuser=documentdata.data() as Map;
      // var q1_doc=q1_snapshot as Map ;
      // var q2_doc=q2_snapshot as Map ;



      if(change_state==0)

       { users.update({"ticked":value});



      // completed.doc(documnent).set(
      //     {"Name":documnent, "Timestamp":time, "ticked":false} // Adds to completed collection
      // );
       if(documentuser['time'].compareTo(Timestamp.fromDate(DateTime.now()))>0 && change_state==0){
         collectquadrant1.update({"Name": FieldValue.increment(1),"color":'0xFF34c9eb',
           "xaxis":'Quadrant1'});

       }

       }

      else{
       quadrant2.update({"ticked":value});
       // completed_quadrant2.doc(documnent).set(
       //      {"Name":documnent, "Timestamp":time, "ticked":false}
       //  );
       if(documentuser['time'].compareTo(Timestamp.fromDate(DateTime.now()))>0 && change_state==1){
         collectquadrant2.update({"Name":FieldValue.increment(1),"color":'0xFFa531e8',
           "xaxis":'Quadrant2'});

       }
      }


      Future.delayed(const Duration(milliseconds: 700), () {
        if(change_state==0)
          users.delete();
          else
            quadrant2.delete();
      });
  }

  Widget build(BuildContext context) {
    final Stream <DocumentSnapshot>firebaselist = FirebaseFirestore.instance.collection('items').doc('itemlist').snapshots(includeMetadataChanges: true) ;
    final Stream <QuerySnapshot> users=FirebaseFirestore.instance.collection('Users').doc(uid).collection('Mytask').orderBy('Timestamp').snapshots(includeMetadataChanges: true);
    final Stream <QuerySnapshot> quadrant2=FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant2').orderBy('Timestamp').snapshots(includeMetadataChanges: true);

    Future<void> usersetup(String task, int flag) async{
      FirebaseAuth auth= FirebaseAuth.instance;
      String uid =auth.currentUser!.uid.toString();
      DateTime currentDate =DateTime.now();
      Timestamp time= Timestamp.fromDate(currentDate);
      Timestamp currentTime= Timestamp.fromDate(currentDate);
      DocumentReference users = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Mytask').doc(task);
      DocumentReference quadrant2 = FirebaseFirestore.instance.collection('Users').doc(uid).collection('Quadrant2').doc(task);
      DocumentReference session=FirebaseFirestore.instance.collection("Users").doc(uid).collection("session_time").doc("time");
      DocumentReference collectquadrant2 = FirebaseFirestore.instance.collection('Users').doc(uid).collection("session").doc('Quadrant2');
      DocumentReference collectquadrant1 = FirebaseFirestore.instance.collection('Users').doc(uid).collection("session").doc('Quadrant1');

      if(flag==0){
        print(task);
        users.set({"Name":task, "Timestamp":time, "ticked":false},SetOptions(merge: true));
      }
      else{
        quadrant2.set({
          "Name": task,
          "Timestamp": time,
          "ticked": false
        });
      }
      var q2_snapshot=await FirebaseFirestore.instance.collection("Users").doc(uid).collection("session").doc("Quadrant2").get();
      var q1_snapshot=await FirebaseFirestore.instance.collection("Users").doc(uid).collection("session").doc("Quadrant1").get();
      var documentdata=await session.get();

      var documentuser=documentdata.data() as Map;
      var q1_doc=q1_snapshot.data() as Map;
      var q2_doc=q2_snapshot.data() as Map;

        //time=documentuser['time'];
        if(flag==0)
        {
          //addsessiontime(time, session,task)  ; // adds the session time to compare with current time
          if(documentuser['time'].compareTo(Timestamp.fromDate(DateTime.now()))>0 && change_state==0){
            collectquadrant1.update({"Name":FieldValue.increment(-2),"color":'0xFF34c9eb',
              "xaxis":'Quadrant1'});
          }
          else
            print(time.toDate());
        }
        else {

          if(documentuser['time'].compareTo(Timestamp.fromDate(DateTime.now()))>0 && change_state==1){
            collectquadrant2.update({"Name":FieldValue.increment(-2),"color":'0xFFa531e8',
              "xaxis":'Quadrant2'});

          }

        }


      return;

    }

    void set_session ()  async {
  setState(() {
    CollectionReference collectquadrant1 = FirebaseFirestore.instance.collection('Users').doc(uid).collection("q1_session");
    DocumentReference session_time= FirebaseFirestore.instance.collection("Users").doc(uid).collection("session_time").doc("time");

    DocumentReference q1_document=  FirebaseFirestore.instance.collection('Users').doc(uid).collection("session").doc('Quadrant1');
    DocumentReference q2_document=  FirebaseFirestore.instance.collection('Users').doc(uid).collection("session").doc('Quadrant2');

    addwithtoday=today.add(new Duration(minutes: 1));
    DateTime currentdate=DateTime.now();
    addwithtoday=currentdate.add(new Duration(minutes: 1));
    Timestamp time=Timestamp.fromDate(addwithtoday);
    session_time.set({
      "time":time
    });

    q1_document.set({
      "Name":0,
      "color":'0xFF34c9eb',
      "xaxis":'Quadrant1'
    });

    q2_document.set({
      "Name":0,
      "color":'0xFFa531e8',
      "xaxis":'Quadrant2'
    });

  });
}
    void add(){
        if(change_state==0) {           //flag 0 for quadrant 1

          tasklist.doc('doc id').set({'task':_namecontroller.text},SetOptions(merge: true));
          firebaselistinstance.doc('itemlist').update({'itemvalue':FieldValue.arrayUnion([_namecontroller.text])});
          usersetup(_namecontroller.text.trim(),change_state); // calls the function which adds to firebase

        }

        else       //flag1 for quadrant 2
        {
        usersetup(_namecontroller.text,change_state);
        }

    }


    void change(int j){


      setState(() {
        change_state=j;
      });
    }
    Future<Null> _selectDate(BuildContext context) async {
      final pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime.now().subtract(Duration(days: 1)),
          lastDate: DateTime(2022));
      if (pickedDate != null && pickedDate != currentDate)
        setState(() {
          currentDate = pickedDate;
          _namecontroller.text=  _namecontroller.text+ ' '+ currentDate.day.toString()+'-'+ currentDate.month.toString()+'-'+
              currentDate.year.toString();
        });
    }
    Future<Null> _selectTime(BuildContext context) async {
      final  TimeOfDay? pickedTime = await showTimePicker(context: context, initialTime: time);
      if (pickedTime != null && pickedTime != time)
        setState(() {
          time = pickedTime;
          _namecontroller.text=  _namecontroller.text+ ' ' +'   '+ time.hour.toString()+':'+time.minute.toString() + ' '+time.period.toString();
        });
    }
    //(uid);

    return MaterialApp(

        home: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [change_state==0?Text("Quadrant 1"):Text("Quadrant 2"),
              Align(
                alignment: Alignment.topRight,

                child: FlatButton(
                  textColor: Colors.white,

                  onPressed:(){

                      User_class userback=User_class(textadd, addquest);
                    Navigator.popUntil(context,ModalRoute.withName('jarvia'));
                   // navigateAndDisplaySelection(context);
                    Navigator.pushNamed(context, "jarvia",
                        arguments: User_class(textadd, addquest));
                    }, child: Text('home'),

                ),

              ),
              Align(
                alignment: Alignment.topRight,
                child: RaisedButton(
                  textColor: Colors.black,
                  onPressed: (){

                   setState(() {
                     context.read<FlutterFireAuthService>().signOut();
                     //Navigator.of(context).pop();

                     Navigator.of(context)
                         .pushNamedAndRemoveUntil('/openview', (Route<dynamic> route) => false);

                   });

                  },child: Text('Sign Out'),
                ),
              ),



              ],)
          ),
          backgroundColor: Colors.black,
          body:


          Column(

          
              mainAxisSize: MainAxisSize.max,

              children:[


                Row(
                  children: [
                    RaisedButton(
                      padding: const EdgeInsets.all(8),

                      onPressed: (){  //ADD button
                      change(0);


                    },
                      child: Text('Quadrant 1'),
                      color: Colors.lightBlue,
                      textColor: Colors.white,
                      hoverColor: Colors.white,
                    ),
                    RaisedButton(onPressed: (){  //ADD button
                      change(1);
                      //print(textadd[addquest-1]);
                      print(change_state);
                    },
                      child: Text('Quadrant 2'),
                      color: Colors.lightBlueAccent,
                    ),
                   RaisedButton(
                      textColor: Colors.black,
                      onPressed: (){

                        setState(() {
                          uid=auth.currentUser!.uid;
                          set_session();

                        });

                      },child: Text('Refresh'),
                    ),
                  ],
                ),
              TextField(
                cursorColor: Colors.black ,
                controller: _namecontroller,
                cursorHeight: 2,

                decoration: InputDecoration(
                    hintText: "Items",
                   filled: true,
                   fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),

              ),

              Row(children: [
                ElevatedButton(

                  onPressed: (){
                  _selectDate(context);
                },
                  child: Text('Select Date'),

                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),

                ),

                ),
                RaisedButton(
                  child: Text('Select Time'),
                  onPressed:(){
                    _selectTime(context);

                  },

                ),
                RaisedButton(onPressed: (){  //ADD button
                  add();
                  _namecontroller.clear();

                },
                  child: Text('Add'),
                ),
              ],),

              RaisedButton(onPressed:() {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/chart', (Route<dynamic> route) => false);

              },child: Text('Session Summary'),
              ),

                //See list button

                if(change_state==0)
                  AddList_State(Textadd: textadd,ondismissed: dismiss,firebaselist: firebaselist,firebasequery: users,flag: change_state,checkbox: checkbox,)


                  else
                     AddList_State(Textadd: textadd,ondismissed: dismiss,firebaselist: firebaselist,firebasequery: quadrant2,flag: change_state,
                     checkbox: checkbox,
                     )

              ]),


        ));
  }
}