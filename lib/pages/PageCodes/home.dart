import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Calendar/calendar.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.drawer,
    required this.signOutButton
  });
  final IconButton signOutButton;
  final Drawer drawer;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _jarviaController = CalendarController();
  DateTime _datePicked = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: _datePicked,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100))
                  .then((DateTime? date) {
                if (date != null) {
                  _jarviaController.displayDate = date;
                }
              });
            },
            icon: Icon(
              Icons.date_range,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: widget.drawer,
      body: JarviaCalendar(),
    );
  }
}

