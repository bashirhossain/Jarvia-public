import 'package:flutter/material.dart';
import 'package:task_manager_app/LoginPage.dart';
import 'package:task_manager_app/NewTask.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager_app/MatrixPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager_app/HomePage.dart';
import 'package:task_manager_app/MatrixPage.dart';
import 'package:task_manager_app/Onboarding.dart';

class ThirdMatrix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: thirdMatrix(),
    );
  }
}
class thirdMatrix extends StatefulWidget {
  @override
  _thirdMatrixState createState() => _thirdMatrixState();
}

class _thirdMatrixState extends State<thirdMatrix> {
  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop  = "close";
  var monthNames = ["January", "February", "March", "April",
    "May", "June", "July", "August", "September",
    "October", "November", "December"];
  CalendarController ctrlr = new CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Color(0xfff96060),
                elevation: 0,
                title: Text("\t\t\t\tThird Matrix", textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
                //actions: [
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MatrixPage()));},
                ),

                actions: [


                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: PopupMenuButton<int>(
                      tooltip: 'Menu',
                      child: Icon(
                        Icons.more_vert,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      onSelected: (item) => onSelected(context, item),
                      itemBuilder: (context) => [


                        PopupMenuItem<int>(
                          value:0,
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline_sharp,
                                color: Colors.black54,
                                size: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text(
                                  "My Tasks",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ),

                        PopupMenuItem<int>(
                          value:1,
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_to_photos_rounded,
                                color: Colors.black54,
                                size: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text(
                                  "Add Task",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),



                        PopupMenuItem<int>(
                          value:2,
                          child: Row(
                            children: [
                              Icon(
                                Icons.apps_sharp,
                                color: Colors.black54,
                                size: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text(
                                  "Matrices",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value:3,
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: Colors.black54,
                                size: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text(
                                  "My Profile",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem<int>(
                          value:4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch_later_sharp,
                                color: Colors.black54,
                                size: 22.0,
                              ),


                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text(
                                  "Sign Out",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],


              ),

              Container(
                height: 70,
                color: Color(0xfff96060),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){changeFilter("today");},
                          child: Text("Today", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType== "today")?Colors.white:Colors.transparent,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){changeFilter("monthly");},
                          child: Text("Weekly", style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType == "monthly")?Colors.white:Colors.transparent,
                        )
                      ],
                    )
                  ],
                ),
              ),
              (filterType == "monthly")?TableCalendar(
                calendarController: ctrlr,
                startingDayOfWeek: StartingDayOfWeek.monday,
                initialCalendarFormat: CalendarFormat.week,
              ):Container(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Today ${monthNames[today.month-1]} ${today.day}, ${today.year}", style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey
                            ), )
                          ],
                        ),
                      ),
                      taskWidget(Colors.red, "Meeting with someone" , "9:00 AM"),
                      taskWidget(Colors.yellow, "Meeting with someone" , "9:00 AM"),
                      taskWidget(Colors.blue, "Meeting with someone" , "9:00 AM"),
                      taskWidget(Colors.green, "Take your medicines" , "9:00 AM"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  changeFilter(String filter)
  {
    filterType = filter;
    setState(() {

    });
  }
  Slidable taskWidget(Color color, String title, String time)
  {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.03),
                offset: Offset(0,9),
                blurRadius: 20,
                spreadRadius: 1
            )]
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color,
                      width: 4)
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                ),),
                Text(time, style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18
                ),)
              ],
            ),
            Expanded(child: Container(),),
            Container(
              height: 50,
              width: 5,
              color: color,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Edit",
          color: Colors.white,
          icon: Icons.edit,
          onTap: (){},
        ),
        IconSlideAction(
          caption: "Delete",
          color: color,
          icon: Icons.edit,
          onTap: (){},
        )
      ],
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => NewTask()),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MatrixPage()),
        );
        break;
      case 3:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Onboarding()),
        );

    }

  }

}