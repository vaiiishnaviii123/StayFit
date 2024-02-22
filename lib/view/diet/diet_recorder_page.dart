import 'package:flutter/material.dart';
import '../event_tracker.dart';
import '../reward_points_page.dart';
import 'diet_manager.dart';

class DietRecorderPage extends StatefulWidget {
  const DietRecorderPage({super.key});

  @override
  _DietRecorderPageState createState() {
    return _DietRecorderPageState();
  }
}

class _DietRecorderPageState extends State<DietRecorderPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        body: ListView(
          children: [
            RewardPointsPage(),
            DietManager(),
            SingleChildScrollView(
              child: EventTracker('DIET'),
            )
          ],
        )
    );
  }
}