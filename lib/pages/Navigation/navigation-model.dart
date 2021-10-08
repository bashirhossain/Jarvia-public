import 'package:flutter/material.dart';
import 'navigation-widget.dart';

class PageViewed extends ChangeNotifier{
  PageBeingViewed _pageBeingViewed = PageBeingViewed.matrix;

  PageBeingViewed get pageBeingViewed => _pageBeingViewed;
  void switchToMatrix(){
    if(_pageBeingViewed!=PageBeingViewed.matrix) {
      _pageBeingViewed = PageBeingViewed.matrix;
      notifyListeners();
    }
  }

  void switchToAnalysis(){
    if(_pageBeingViewed!=PageBeingViewed.analysis) {
      _pageBeingViewed = PageBeingViewed.analysis;
      notifyListeners();
    }
  }
  void switchToHome(){
    if(_pageBeingViewed!=PageBeingViewed.home) {
      _pageBeingViewed = PageBeingViewed.home;
      notifyListeners();
    }
  }
}