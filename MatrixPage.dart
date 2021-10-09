import 'package:flutter/material.dart';
import 'package:task_manager_app/SecondMatrix.dart';
import 'package:task_manager_app/FirstMatrix.dart';
import 'package:task_manager_app/ThirdMatrix.dart';
import 'package:task_manager_app/FourthMatrix.dart';
import 'package:task_manager_app/Onboarding.dart';
import 'package:task_manager_app/NewTask.dart';
import 'package:task_manager_app/LoginPage.dart';
import 'package:task_manager_app/HomePage.dart';



class MatrixPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: loginPage(),
    );
  }
}
class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:

        AppBar(
          backgroundColor: Color(0xfff96060),
          elevation: 0,
          title: Text("\t\t\t\tMatrices", textAlign: TextAlign.center, style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),),
          //actions: [
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding()));},
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






      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                  InkWell(
                    onTap: openFirstMatrix,
                    child: Container(
                      height:110,
                      width: 320,
                     // alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          color: Colors.red,
                      ),
                      child: Center(
                      child: Text("   Matrix 1\n* Urgent\n* Important", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),),
                    ),
                  ),
          ],
                  ),
                  SizedBox(height:15,),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
            children:[
                  InkWell(
                    onTap: openSecondMatrix,
                    child: Container(
                      height:110,
                      width: 320,
                      // alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        color: Colors.blue,
                      ),
                      child: Center(
                      child: Text("   MATRIX 2\n* Urgent\n* Not Important", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),),
                    ),
                  ),
                  ],
           ),
                  SizedBox(height:15,),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[

                  InkWell(
                    onTap: openThirdMatrix,
                    child: Container(
                      height:110,
                      width: 320,
                      // alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        color: Colors.green,
                      ),
                      child: Center(
                      child: Text("   MATRIX 3\n* Not Urgent\n* Important", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),),
                    ),
                  ),
                  ],
      ),
                  SizedBox(height:15,),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
                  InkWell(
                    onTap: openFourthMatrix,
                    child: Container(
                      height:110,
                      width: 320,
                      // alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                        color: Colors.pink,
                      ),
                      child: Center(
                        child:Text("   Matrix 4\n* Not Urgent\n* Not Important", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),),
                    ),
                  ),
          ],
      ),
SizedBox(height:35,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                          InkWell(
                            onTap: openNewTask,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                color: Color(0xfff96060),

                              ),
                              child: Center(
                                child: Text("+", style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          ),
                    ],
                  )





                ],
          ),
        ),
    );
  }







void openFirstMatrix()
    {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstMatrix()));
    }

  void openSecondMatrix()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondMatrix()));
  }

  void openThirdMatrix()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ThirdMatrix()));
  }

  void openFourthMatrix()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>FourthMatrix()));
  }
  void openNewTask()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewTask()));
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