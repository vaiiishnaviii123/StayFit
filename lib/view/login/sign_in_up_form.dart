import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/navigation.dart';

class LoginRegisterForm extends StatefulWidget {
  const LoginRegisterForm({super.key});

  @override
  State<LoginRegisterForm> createState() => _LoginRegisterFormState();
}

class _LoginRegisterFormState extends State<LoginRegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _firebaseErrorCode;

  void onSignIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _usernameController.text,
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
      });
    }
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
                child: TextFormField(
                  controller: _usernameController,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    hintText: 'Email ID',
                    hintStyle: TextStyle(color: Colors.black45),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid email Id.';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.35),
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
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.black45),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color:
                            _obscureText == false ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // context.read<LoginRegister>().onSignIn(
                      //     _usernameController.text, _passwordController.text);
                      onSignIn();
                    }
                    FocusScope.of(context).unfocus();
                  }),
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
            ]),
      ),
      ),
    ),
      ),
    );
  }
}
