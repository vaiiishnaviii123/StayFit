import 'package:flutter/material.dart';
import 'package:stay_fit/workout/workout_manager.dart';

import '../event.dart';
import '../event_tracker.dart';

class WorkoutRecorderPage extends StatefulWidget {
  const WorkoutRecorderPage({super.key});

  @override
  _WorkoutRecorderPageState createState() {
    return _WorkoutRecorderPageState();
  }
}

class _WorkoutRecorderPageState extends State<WorkoutRecorderPage> {

  final List<Event> _workoutEvents = [];

  _addWorkoutEvent(Event event) {
    setState(() {
      _workoutEvents.add(event);
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
            WorkoutManager(_addWorkoutEvent),
            EventTracker(_workoutEvents),
          ],
        )
    );
  }
}