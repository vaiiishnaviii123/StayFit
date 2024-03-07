import 'package:flutter/material.dart';
import '../../models/navigation.dart';

class LoginRequestForm extends StatelessWidget {
  LoginRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login to check Leader board: "),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                RouterNavigation.getRouter().go('/login');
              },
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
