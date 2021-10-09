import 'package:flutter/material.dart';
import 'package:task_manager_app/Onboarding.dart';
class RegistrationSuccessful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: passwordChangedSuccessfully(),
    );
  }
}
class passwordChangedSuccessfully extends StatefulWidget {
  @override
  _passwordChangedSuccessfullyState createState() => _passwordChangedSuccessfullyState();
}

class _passwordChangedSuccessfullyState extends State<passwordChangedSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/image/success.png")
                )
            ),
          ),
          Text("Congrats!", style: TextStyle(
              fontSize: 35,
                  fontWeight: FontWeight.bold
          ),),
          Text("Your account has been created", style: TextStyle(
            fontSize: 20,
          ),textAlign: TextAlign.center,),
          SizedBox(height: 70,),
          Center(
            child: InkWell(
              onTap: openOnboardingPage,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    color: Color(0xfff96060)
                ),
                child: Text("Continue", style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void openOnboardingPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding()));
  }
}
