import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/navigation.dart';
import '../../providers/leaderboard_database_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LeaderBoardDatabase database = new LeaderBoardDatabase();
  String? _firebaseErrorCode;
  String? _firebaseErrorMessage;
  bool _isChecked = false;
  var _auth = FirebaseAuth.instance;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  _onSignUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _firebaseErrorCode = null;
      });
      RouterNavigation.getRouter().go("/leaderboard");
    } on FirebaseAuthException catch (ex) {
      print("error occured");
      print(ex.code);
      print(ex.message);
      setState(() {
        _firebaseErrorCode = ex.code;
        _firebaseErrorMessage = ex.message;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
      body: SingleChildScrollView(
     child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign-Up for Leaderboard",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(191, 186, 188, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid email Id eg: xyz@xya.com';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Email ID',
                    hintStyle: TextStyle(color: Colors.black45),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(191, 186, 188, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid password.';
                    }
                    return null;
                  },
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Password: min 6 characters long',
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
              if (_firebaseErrorCode != null) Text('Error: ${_firebaseErrorCode!}: ${_firebaseErrorMessage!}', style: TextStyle(color: Colors.red)),
              CheckboxListTile(
                fillColor: _isChecked? MaterialStateColor.resolveWith((states) => Colors.green): MaterialStateColor.resolveWith((states) => Colors.red),
                value: _isChecked,
                onChanged: (val) {
                  setState(() => _isChecked = val!);
                },
                subtitle: !_isChecked
                    ? Text(
                  'Required*.',
                  style: TextStyle(color: Colors.red),
                )
                    : null,
                title: new Text(
                  "By signing up you agree that your score data will be shared with other users on the app. You are required to agree to proceed with the registration.",
                  style: TextStyle(fontSize: 14.0),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: const Text('Sign up'),
                onPressed: (){
                if (_formKey.currentState!.validate()) {
                  if (_isChecked) {
                    _onSignUp();
                  } else {
                    setState(() {
                      _isChecked = _isChecked;
                    });
                  }
                }
                FocusScope.of(context).unfocus();
                }
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        RouterNavigation.getRouter().go('/login');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
                  GestureDetector(
                      onTap: () {
                        RouterNavigation.getRouter().go('/emoji/tracker');
                      },
                      child: Text(
                        "Go to Home",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                  ),
            ],
          ),
        ),
      ),
      ),
      ),
    );
  }
}