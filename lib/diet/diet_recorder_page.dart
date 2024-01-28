import 'package:flutter/material.dart';
import 'package:stay_fit/diet/diet_manager.dart';

import '../event.dart';

class DietRecorderPage extends StatefulWidget {
  const DietRecorderPage({super.key});

  @override
  _DietRecorderPageState createState() {
    return _DietRecorderPageState();
  }
}

class _DietRecorderPageState extends State<DietRecorderPage> {
  final List<Event> _dietEvents = [];

  _addDietEvent(Event event) {
    setState(() {
      _dietEvents.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          title: Center(
            child: Text(
              'How do you feel today?',
              style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary),
            ),
          ),
        ),
        body: ListView(
          children: [
            DietManager(),
            //EventTracker(_emotionEvents),
          ],
        )
    );
  }
}