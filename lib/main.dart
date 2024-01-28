import 'package:flutter/material.dart';
import 'package:stay_fit/diet_manager.dart';
import 'package:stay_fit/emoji_recorder.dart';
import 'package:stay_fit/emoji_recorder_page.dart';
import 'package:stay_fit/workout_manager.dart';

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
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: const DietManager(),
                )
            ),
            Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: const WorkoutManager(),
                )
            ),
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
