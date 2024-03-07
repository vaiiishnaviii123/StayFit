import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stay_fit/view/leaderboard/leaderboard_page.dart';
import 'package:stay_fit/view/login/sign_in_up_form.dart';

import '../leaderboard/login_request_form.dart';

class SignedInDetector extends StatefulWidget {
  SignedInDetector({super.key});

  @override
  _SignedInDetectorState createState() {
    return _SignedInDetectorState();
  }
}

class _SignedInDetectorState extends State<SignedInDetector> {
  bool _isLoggedIn = false;
  var _auth = FirebaseAuth.instance;

  _checkIfLogin() async{
  _auth.authStateChanges().listen((User? user){
    if(user !=null && mounted){
      setState(() {
        _isLoggedIn = true;
      });
    }
  });
  }
  @override
  void initState() {
    _checkIfLogin();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
        child: _isLoggedIn? LeaderboardPage() : LoginRequestForm(),
    );
  }
}
