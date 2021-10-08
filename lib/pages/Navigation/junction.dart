import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation-model.dart';
import 'navigation-widget.dart';

class Junction extends StatelessWidget {
  Junction({required this.signOut});
  final Function signOut;
  @override
  Widget build(BuildContext context) {
    return Consumer<PageViewed>(
      builder: (context, pageBeingViewed, child){
        return ViewPage(
          pageBeingViewed: pageBeingViewed.pageBeingViewed,
          switchToMatrix: pageBeingViewed.switchToMatrix,
          switchToAnalysis: pageBeingViewed.switchToAnalysis,
          switchToHome: pageBeingViewed.switchToHome,
          signOut: signOut,
        );
      },
    );
  }
}