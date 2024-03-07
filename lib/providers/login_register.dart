import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginRegister extends ChangeNotifier{
  bool isLoggedIn = false;
  late FirebaseAuth _auth;
  String? firebaseErrorCode;

   LoginRegister(){
    _auth = FirebaseAuth.instance;
  }

   void checkIfLogin() async{
    _auth.authStateChanges().listen((User? user){
      if(user !=null){
          isLoggedIn = true;
      }
    });
  }

  // void onSignIn(String username, String password) {
  //  _auth.signInWithEmailAndPassword(
  //     email: username,
  //     password: password,
  //   );
  // }

  void onSignIn(String username, String password) async {
    try {
      _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      firebaseErrorCode = null;
    } on FirebaseAuthException catch (ex) {
      print(ex.code);
      print(ex.message);
      firebaseErrorCode = ex.code;
    }
    notifyListeners();
  }

  void onSignOut(){
   _auth.signOut();
  }

}