import 'package:flutter/material.dart';

class Task{
  Task(
      {
        required this.quadrant,
        required this.from,
        required this.to,
        this.background = const Color(0xFF4CAF50),
        this.isAllDay = false,
        this.eventName = '',
        this.startTimeZone = '',
        this.endTimeZone = '',
        this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
  final String quadrant;
}