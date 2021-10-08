import 'package:flutter/material.dart';
import 'package:jarvia_prime/Firebase-Interaction/Read/read.dart';
import "package:jarvia_prime/utilities/data_classes/tasks.dart";
import 'package:intl/intl.dart';
import 'package:jarvia_prime/utilities/widgets.dart';
import 'task_view.dart';

class TaskSliverList extends StatefulWidget {

  @override
  _TaskSliverListState createState() => _TaskSliverListState();
}
Future<Map<String,List<Task>>>? _futureOfTasks;

class _TaskSliverListState extends State<TaskSliverList> {
  @override
  void initState() {
    _futureOfTasks = getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget sliverView = getSliverList();
    return sliverView;
  }

  Widget getSliverList(){
    Map<String,List<Task>> _mapOfTasks;

    Widget sliverList = FutureBuilder(
        future: _futureOfTasks,
        builder: (BuildContext context, AsyncSnapshot<Map<String,List<Task>>> snapshot){
          if(snapshot.hasData){
            _mapOfTasks = snapshot.data!;
            List<Task> quadrant1 = _mapOfTasks["Quadrant 1"]!;
            List<Task> quadrant2 = _mapOfTasks["Quadrant 2"]!;
            List<Task> quadrant3 = _mapOfTasks["Quadrant 3"]!;
            List<Task> quadrant4 = _mapOfTasks["Quadrant 4"]!;

            quadrant1.sort((a, b) => a.from.millisecondsSinceEpoch.compareTo(b.from.millisecondsSinceEpoch));
            quadrant2.sort((a, b) => a.from.millisecondsSinceEpoch.compareTo(b.from.millisecondsSinceEpoch));
            quadrant3.sort((a, b) => a.from.millisecondsSinceEpoch.compareTo(b.from.millisecondsSinceEpoch));
            quadrant4.sort((a, b) => a.from.millisecondsSinceEpoch.compareTo(b.from.millisecondsSinceEpoch));

            return CustomScrollView(
              slivers: [
                makeHeader("Quadrant 1", Colors.deepOrange),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index){
                        return makeTile(quadrant1, index);
                      },
                      childCount: quadrant1.length,
                    ),
                ),
                makeHeader("Quadrant 2", Colors.lightGreen),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index){
                      return makeTile(quadrant2, index);
                    },
                    childCount: quadrant2.length,
                  ),
                ),
                makeHeader("Quadrant 3", Colors.blueGrey),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index){
                      return makeTile(quadrant3, index);
                    },
                    childCount: quadrant3.length,
                  ),
                ),
                makeHeader("Quadrant 4", Colors.purple),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index){
                      return makeTile(quadrant4, index);
                    },
                    childCount: quadrant4.length,
                  ),
                ),
              ],
            );
          }else{
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ],
                ),
              ),
            );
          }
        },
    );

    return sliverList;
  }

  List<Widget>? quadrantShower(List<Task> quadrant){
    if(quadrant.isEmpty){
      return null;
    }
    List<Widget> sliverSection = <Widget>[];
    sliverSection
        .add(
        makeHeader(
            quadrant[0].quadrant,
            Colors.blueGrey
        )
    );
    SliverList sliverList = SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
          return makeTile(quadrant, index);
        },
        childCount: quadrant.length,
      ),
    );
    sliverSection.add(sliverList);
  }

  Widget makeHeader(String headerText, MaterialColor color) {
    List<Widget> sideColumn = quadrantPositionInMatrix(headerText);
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeadBarDelegate(
        minHeight: 60.0,
        maxHeight: 100.0,
        child: GestureDetector(
          child: Container(
              color: color,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 30.0, 0, 40.0),
                    child: Text(
                        headerText,
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  ...sideColumn
                ]
              ),
          ),
        ),
      ),
    );
  }

  Map<String, Icon> _quadrantUrgencyMap = {
    "Quadrant 1": Icon(Icons.done),
    "Quadrant 2": Icon(Icons.close),
    "Quadrant 3": Icon(Icons.done),
    "Quadrant 4": Icon(Icons.close),
  };

  Map<String, Icon> _quadrantImportanceMap = {
    "Quadrant 1": Icon(Icons.done),
    "Quadrant 2": Icon(Icons.done),
    "Quadrant 3": Icon(Icons.close),
    "Quadrant 4": Icon(Icons.close),
  };

  List<Widget> quadrantPositionInMatrix(String header){
    List<Widget> tiles = [];
    Row line1 = Row(
      children:[
        Text(
          "Urgent"
        ),
        _quadrantUrgencyMap[header]!,
      ]
    );
    Row line2 = Row(
        children:[
          Text(
              "Important"
          ),
          _quadrantImportanceMap[header]!,
        ]
    );
    tiles = [line1,line2];
    return tiles;
  }

  Widget makeTile(List<Task> quadrant, int index){
    return ListTile(
      tileColor: Colors.black,
      hoverColor: Colors.black12,
      title: Text(
          quadrant[index].eventName,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
          "${DateFormat.yMMMd().add_jm().format((quadrant[index].from))} to ${DateFormat.yMMMd().add_jm().format((quadrant[index].to))}",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: (){
        showDialog(
            context: context,
            builder: (context){
              return TaskView(quadrant[index]);
            }
         );
      },
    );
  }

  Future<Map<String,List<Task>>> getAllTasks() async{
    Map<String, dynamic> readerMap = {};
    Map<String,List<Task>> allTasksMap = {};

    await Reader.readAllTasks().then(
            (tasks) => {
              setState(()=>{
                readerMap = tasks
              })
            }
    );

    readerMap.forEach((quadrant, taskList) {
      allTasksMap["$quadrant"] = taskList;
    });
    return allTasksMap;
  }
}
