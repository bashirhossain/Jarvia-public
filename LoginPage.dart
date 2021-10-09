import 'package:flutter/material.dart';
import 'package:task_manager_app/Forgotpassword.dart';
import 'package:task_manager_app/RegisterPage.dart';
import 'package:task_manager_app/HomePage.dart';
import 'package:task_manager_app/Onboarding.dart';
class LoginPage extends StatelessWidget {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Welcome Back!", style: TextStyle(
                fontSize: 35
            ),),
            Text("Sign in to continue...", style: TextStyle(
                fontSize: 18,
                color: Colors.grey
            ),),
            SizedBox(height: 20,),
            Text("User Name", style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter your name here"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 40,),
            Text("Password", style: TextStyle(
              fontSize: 23,
                fontWeight: FontWeight.bold
            ),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter your password here"
              ),
              style: TextStyle(
                  fontSize: 20
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: openForgotPassword,
                  child: Text("Forgot Password?", style: TextStyle(
                      fontSize: 16
                  ),),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  InkWell(
                     onTap: openHomePage,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                      color: Color(0xfff96060)
                  ),
                  child: Text("Log In", style: TextStyle(
                      fontSize: 19,
                      color: Colors.white
                  ),),
                ),
                  ),
                  SizedBox(height: 15,),
                  InkWell(
                    onTap: openRegisterPage,
                    child: Text("Create new account", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        decoration: TextDecoration.underline
                    ),),
                  ),
              ],
              ),
              ),
          ],
        ),
      ),
    );
  }
  void openForgotPassword()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
  }
  void openHomePage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }

  void openRegisterPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage() ));
  }




}