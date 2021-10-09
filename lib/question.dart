

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jarvia/TestApp.dart';
import 'package:jarvia/TestAppState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'TestAppState.dart';

import 'main.dart';


// class Addlist extends StatefulWidget {
//   final List Textadd ;
//   final Function(List,int) ondismissed;
//   final Stream<DocumentSnapshot> firebaselist;
//   final Stream<QuerySnapshot>firebasequery;
//    int flag;
//   Addlist({required this.Textadd,  required this.ondismissed,required this.firebaselist,required this.firebasequery,required this.flag});
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//
//     print(flag.toString() + 'addlist');
//
//     return
//       AddList_State(Textadd: textadd1,ondismissed: ondismissed,firebaselist: firebaselist,firebasequery: firebasequery,flag: flag);
//
//
//     //throw UnimplementedError();
//
//
//   }
//
// }
class AddList_State  extends StatelessWidget{
  bool _value = false;
  List Textadd ;
  Function(String) ondismissed;
  Function(String,bool) checkbox;
  Stream<DocumentSnapshot> firebaselist;
  Stream<QuerySnapshot>firebasequery;


   int flag;
  AddList_State({required this.Textadd,  required this.ondismissed,required this.firebaselist,required this.firebasequery,required this.flag,
  required this.checkbox
  });


  List list1=[''];
  Widget build(BuildContext context){
    // print("dsa");
    // print(flag);

    return Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: firebasequery,          //.doc('itemvalue').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          //Map data1 = snapshot.data as Map;
          // Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
          //print(data['itemvalue'][0]+ 'engage');

          return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<dynamic, dynamic> data = document.data()! as Map<dynamic, dynamic>;
            return Dismissible(key: UniqueKey(),


                onDismissed:(DismissDirection){
                  ondismissed(data['Name']);

                },

                child: CheckboxListTile(
              title: Text(data['Name'].toString()), value: data['ticked'],
               onChanged: (bool? value){

                checkbox(data['Name'],value!);

              }
            ,
                    tileColor: Colors.blue
            )



            );

          }).toList(),
          );}
    ),
    );

  }
}



// class UserInformation extends StatefulWidget {
//   @override
//   _UserInformationState createState() => _UserInformationState();
// }
//
// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }
//
//         return ListView(
//           children: snapshot.data!.docs.map((DocumentSnapshot document) {
//             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//             return ListTile(
//               title: Text(data['full_name']),
//               subtitle: Text(data['company']),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }

