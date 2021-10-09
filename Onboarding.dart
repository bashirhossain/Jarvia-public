import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:task_manager_app/LoginPage.dart';
import 'package:task_manager_app/HomePage.dart';
class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'avenir'
      ),
      home: onboarding(),
    );
  }
}
class onboarding extends StatefulWidget {

  @override
  _onboardingState createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  int currentPage = 0;
  PageController _pageController = new PageController(
      initialPage: 0,
      keepPage: true
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.6,
                child: PageView(
                  controller: _pageController,
                  children: [
                    onBoardPage("1",
                        "Welcome to MyFocus",
                        "MyFocus is a daily life app to increase your productivity and progress indicator"),
                    onBoardPage( "2",
                        "Get Things Done",
                        "Prioritize your tasks and get them done accordingly"),
                    onBoardPage("3",
                        "See Your Progress",
                        "Track your progress on basis of your accomplishments of enlisted tasks"),
                  ],
                  onPageChanged: (value)=>{setCurrentPage(value)},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => getIndicator(index)),
              )
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: 260,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/image/path1.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: openHomePage,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(11)),
                          boxShadow: [BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0,9),
                              blurRadius: 20,
                              spreadRadius: 3
                          )]
                      ),
                      child: Text("Get Started", style: TextStyle(
                          fontSize: 16
                      ),),
                    ),
                  ),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: openLoginPage,
                      child: Text("Login/Register", style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                      ),),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  AnimatedContainer getIndicator(int pageNo)
  {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      height: 10,
      width: (currentPage == pageNo) ? 20 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: (currentPage == pageNo) ? Colors.black : Colors.grey
      ),
    );
  }
  Column onBoardPage(String img, String title, String detail)
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('asset/image/$img.png'),
              )
          ),
        ),
        SizedBox(height: 50,),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(title, style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500
          ),),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: Text(detail, style: TextStyle(
              fontSize: 16,
              color: Colors.grey
          ),textAlign: TextAlign.center,),
        )
      ],
    );
  }
  setCurrentPage(int value)
  {
    currentPage = value;
    setState(() {

    });
  }
  openLoginPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  }
  openHomePage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
}