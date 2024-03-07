import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stay_fit/firebase_options.dart';
import 'package:stay_fit/view/login/signed_in_detector.dart';

class FirebaseInitializer extends StatelessWidget {
  const FirebaseInitializer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return SignedInDetector();
        } else if(snapshot.hasError) {
          return const Text('Oh no! You can\'t connect to Firebase.');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
