import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login_authentication.dart';

class LoginState extends ChangeNotifier {
  LoginState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = AppLoginState.loggedIn;
      } else {
        _loginState = AppLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  AppLoginState _loginState = AppLoginState.loggedOut;

  AppLoginState get loginState => _loginState;

  String? _email;

  String? get email => _email;

  void startLoginFlow() {
    _loginState = AppLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> verifyEmail(
      String email,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try{
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')){
        _loginState = AppLoginState.password;
      } else{
        _loginState = AppLoginState.register;
      }

      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e){
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration(){
    _loginState = AppLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback
      ) async {
    try{
      var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

}