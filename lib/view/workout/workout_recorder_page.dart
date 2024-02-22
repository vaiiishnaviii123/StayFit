import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/view/workout/workout_manager.dart';
import '../event_tracker.dart';
import '../../models/reward.dart';
import '../../providers/reward_points.dart';
import '../reward_points_page.dart';

class WorkoutRecorderPage extends StatefulWidget {
  const WorkoutRecorderPage({super.key});

  @override
  _WorkoutRecorderPageState createState() {
    return _WorkoutRecorderPageState();
  }
}

class _WorkoutRecorderPageState extends State<WorkoutRecorderPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        body: ListView(
          children: [
            RewardPointsPage(),
            WorkoutManager(),
            //EventTracker(context.watch<WorkoutList>().getWorkoutList(), 'WORKOUT'),
            SingleChildScrollView(
              child: EventTracker('WORKOUT'),
            )
          ],
        )
    );
  }
}