import 'package:charts_flutter/flutter.dart' as charts;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'TestAppState.dart';
class Session_Object{
  final int value;
  final String xaxis;
  final String color;
  Session_Object({required this.value,required this.xaxis, required this.color});
 Session_Object.fromMap(Map<String,dynamic>map,)
      :assert(map['Name']!=null),
      assert(map['xaxis']!=null),
      assert(map['color']!=null),
  value=map['Name'],
  xaxis=map['xaxis'],
  color=map['color'];

@override
  String toString()=>"R";
}

class Session extends StatefulWidget{

    _SessionState createState()=> _SessionState();

}
FirebaseAuth auth= FirebaseAuth.instance;

class _SessionState extends State<Session> {
   List<charts.Series<Session_Object, String>> _seriesBarData=[];

   List<Session_Object>mydata=[];


  _generatechart(mydata) {
    _seriesBarData.add(
        charts.Series(
            domainFn: (Session_Object session_axis, _) =>
                session_axis.xaxis.toString(),
            measureFn: (Session_Object session_axis, _) => session_axis.value,
            colorFn: (Session_Object session_axis, _) =>
                charts.ColorUtil.fromDartColor(
                  Color(int.parse(session_axis.color)),),
            data: mydata,
            id: 'Session'

        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text('Session Summary'),),
      body: _buildbody(context),);
  }


  Widget _buildbody(context) {
    String uid = auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Users")
            .doc(uid)
            .collection("session")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          else {
            List<Session_Object> session = snapshot.data!.docs.map((
                DocumentSnapshot snapshot) =>
                Session_Object.fromMap(snapshot.data() as Map<String, dynamic>))
                .toList();
            return _buildChart(context, session);
          }
        }

    );
  }

  Widget _buildChart(BuildContext context, List<Session_Object> session) {
    mydata = session;
    _generatechart(mydata);
    return Padding(padding: EdgeInsets.all(5.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Session adding summary"),
           RaisedButton(onPressed: (){
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/profile', (Route<dynamic> route) => false);

    },child: Text('Add'),),

           SizedBox(height: 5.0,),
              Expanded(
                  child:charts.BarChart(_seriesBarData,
                      animate: true,
                    animationDuration: Duration(seconds: 3),


                  )


              ),
            ],

          ),
        ),
      ),

    );
  }
}
  