import 'package:flutter/material.dart';
import 'sliver/task_list.dart';

class TheMatrix extends StatelessWidget {
  TheMatrix();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TaskSliverList(),
    );
  }
}

