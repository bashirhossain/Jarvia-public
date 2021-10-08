import 'package:flutter/material.dart';
import '../Analysis/current-week.dart';
import '../Analysis/all-weeks.dart';
import 'package:jarvia_prime/Firebase-Interaction/Write/write_all_week_records.dart';

class Analysis extends StatefulWidget {
  Analysis({
    required this.signOutButton,
    required this.drawer
  });
  final Drawer drawer;
  final IconButton signOutButton;

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  String chosenGraph = "CurrentWeek";

  Widget? chart;

  @override
  Widget build(BuildContext context) {

    AllWeekWriter.updateWeeksRecord();
    switch(chosenGraph){
      case "CurrentWeek":
        chart = CurrentWeekChart();
        break;
      case "AllWeeks":
        chart = AllWeekChart();
        break;
      default:
        chart = Container(
          child: Center(
            child: Text(
              "There has been an error loading your chart."
            ),
          ),
        );

    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            onSelected: (String value){
              setState(() {
                chosenGraph = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: "CurrentWeek",
                child: Text('Report of this week'),
              ),
              const PopupMenuItem<String>(
                value: "AllWeeks",
                child: Text('Report across the weeks'),
              ),
            ],
          )
        ]
      ),
      drawer: widget.drawer,
      body: chart,
    );
  }
}


