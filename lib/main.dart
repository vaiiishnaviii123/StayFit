import 'package:flutter/material.dart';
import 'package:stay_fit/diet/diet_manager.dart';
import 'package:stay_fit/diet/diet_recorder_page.dart';
import 'package:stay_fit/emotions/emoji_recorder_page.dart';
import 'package:stay_fit/workout/workout_manager.dart';
import 'package:stay_fit/workout/workout_recorder_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayFit',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'StayFit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(82, 7, 39, 2),
        title: Text(widget.title, style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        color: Color.fromRGBO(191, 186, 188, 1),
        child: PageView(
          controller: controller,
          children: const <Widget>[
            Center(
              child: const EmojiRecorderPage(),
            ),
            Center(
              child: const DietRecorderPage(),
            ),
            Center(
                child:  const WorkoutRecorderPage(),
            ),
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
