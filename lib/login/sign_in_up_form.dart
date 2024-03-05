import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/navigation.dart';

class LoginRegisterForm extends StatefulWidget {
  const LoginRegisterForm({super.key});

  @override
  State<LoginRegisterForm> createState() => _LoginRegisterFormState();
}

class _LoginRegisterFormState extends State<LoginRegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _firebaseErrorCode;
  bool _obscureText = true;

  _onSignUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameController.text,
        password: _passwordController.text,
      );
      setState(() {
        _firebaseErrorCode = null;
      });
    } on FirebaseAuthException catch (ex) {
      print(ex.code);
      print(ex.message);
      setState(() {
        _firebaseErrorCode = ex.code;
      });
    }
  }

  _onSignIn() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _usernameController.text,
      password: _passwordController.text,
    );
  }

  _onSignOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
        Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _usernameController,
            decoration: new InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintText: 'Email ID',
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: _obscureText,
            decoration: new InputDecoration(
              border: InputBorder.none,
              filled: true,
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.black45),
              suffixIcon: new GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child:
                Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: _obscureText == false ? Colors.blue : Colors.grey,),
              ),
            ),
          ),
        ),
        ElevatedButton(
          child: const Text('Sign In'),
          onPressed: _onSignIn,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  RouterNavigation.getRouter().go('/signUp');
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
        ),
        if (_firebaseErrorCode != null) Text(_firebaseErrorCode!),
      ]),
    );
  }
}
