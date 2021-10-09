import 'package:flutter/material.dart';
import 'package:task_manager_app/RegistrationSuccessful.dart';
import 'package:task_manager_app/Onboarding.dart';
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: registerPage(),
    );
  }
}
class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding()));},
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),

            Text("  JUMP INTO A FOCUSED LIFE",style: TextStyle(
                fontSize: 23,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Color(0xfff96060)
            ),textAlign: TextAlign.center),
            SizedBox(height: 30,),
            Text("User Name", style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter your username"
              ),
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(height: 20,),

            Text("E-mail ID", style: TextStyle(
              fontSize: 19,
                fontWeight: FontWeight.bold
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter your email id"
              ),
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(height: 20,),

            Text("Password", style: TextStyle(
              fontSize: 19,
                fontWeight: FontWeight.bold
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter password"
              ),
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(height: 20,),

            Text("Confirm Password", style: TextStyle(
              fontSize: 19,
                fontWeight: FontWeight.bold
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter password again"
              ),
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            SizedBox(height: 5,),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  InkWell(
                    onTap: openRegistrationSuccessfulPage,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          color: Color(0xfff96060)
                      ),
                      child: Text("Register", style: TextStyle(
                          fontSize: 19,
                          color: Colors.white
                      ),),
                    ),
                  ),
                  //SizedBox(height: 25,),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openRegistrationSuccessfulPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationSuccessful()));
  }
}