import 'package:flutter/material.dart';
import 'package:jarvia_prime/utilities/widgets.dart';
import '../Pagecodes/analysis.dart';
import '../Pagecodes/home.dart';
import '../Pagecodes/matrix.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

enum PageBeingViewed{
  home,
  matrix,
  analysis,
}

class ViewPage extends StatelessWidget {
  ViewPage(
      {
        required this.pageBeingViewed,
        required this.switchToHome,
        required this.switchToMatrix,
        required this.switchToAnalysis,
        required this.signOut,
      }
      );

  final PageBeingViewed pageBeingViewed;
  final void Function() switchToHome;
  final void Function() switchToMatrix;
  final void Function() switchToAnalysis;
  final Function signOut;


  @override
  Widget build(BuildContext context) {
    Drawer drawer = Drawer(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.005, 145, 0.0),
              child: Text(
                "Jarvia",
                style: GoogleFonts.italianno(
                  color: Colors.deepPurple,
                  fontSize: 20
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.005, 145, 0.0),
              child: Text(
                "Team Tea BAG",
                style: GoogleFonts.italiana(
                    color: Colors.deepPurple,
                    fontSize: 12
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 100, 60, 0.0),
              child: Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: GoogleFonts.oxygen(
                  fontSize: 40,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 80, 0.0, 0.0),
              child: StyledButton(
                child: Text("Matrix"),
                onPressed: (){
                  switchToMatrix();
                  Navigator.pop(context);
                },
              ),
            ),
            StyledButton(
              child: Text("Analysis"),
              onPressed: (){
                switchToAnalysis();
                Navigator.pop(context);
              },
            ),
            StyledButton(
              child: Text("Calendar"),
              onPressed: (){
                switchToHome();
                Navigator.pop(context);
              },
            ),
            Expanded(child: Container()),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40),
              child: StyledButton(
                child: Text(
                  "SignOut",
                  style: TextStyle(
                    color: Colors.red[700]
                  ),
                ),
                onPressed: ()=>signOut(),
              ),
            ),
          ],
        ),
      ),
    );


    IconButton signOutButton = IconButton(
      onPressed: ()=>signOut(),
      icon: const Icon(Icons.exit_to_app_outlined, color: Colors.red,),
    );


    switch (pageBeingViewed){
      case PageBeingViewed.home:
        return HomePage(
          drawer: drawer,
          signOutButton: signOutButton,
        );
      case PageBeingViewed.matrix:
        return Matrix(
          drawer: drawer,
          signOutButton: signOutButton,
        );
      case PageBeingViewed.analysis:
        return Analysis(
          drawer: drawer,
          signOutButton: signOutButton,
        );
      default:
        return Container(
          child: Text(
              "Something went wrong"
          ),
        );
    }
  }
}
