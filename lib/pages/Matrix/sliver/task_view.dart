import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jarvia_prime/utilities/data_classes/tasks.dart';
import 'package:jarvia_prime/utilities/widgets.dart';

class TaskView extends StatelessWidget {
  TaskView(this.task);
  final Task task;

  Widget clock = Container();

  Widget getClock(){
    if(!task.isAllDay){
      clock = Column(
        children: [
          Text(
              "${DateFormat.jm().format((task.from))}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            )
          ),
          Text(
              "${DateFormat.jm().format((task.to))}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )
          )
        ],
      );
    }
    return clock;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 0.0, 0.0),
              child: Text(
                  task.eventName,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black
                ),
              ),
            ),
            expandedHeight: 160.0,
            backgroundColor: QuadrantColorMapping[task.quadrant],
            snap: true,
            floating: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  ListTile(
                    leading: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 10, 0.0, 0.0),
                      child: Icon(
                        Icons.access_time_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 10, 0.0, 0.0),
                            child: Text(
                                "${DateFormat.yMMMd().format((task.from))}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30.0, 10, 0.0, 0.0),
                            child: Text(
                              "${DateFormat.yMMMd().format((task.to))}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Padding(
                        padding: EdgeInsets.only(right: 30.0),
                        child: getClock(),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 0.0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.white30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 0.0),
                    child: Text(
                      task.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ]
              )
          ),
        ],
      ),
    );
  }
}
