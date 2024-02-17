import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/diet/diet_manager.dart';
import 'package:stay_fit/Models/event.dart';
import 'package:stay_fit/providers/event_diet_list.dart';
import '../entity/show_emotion_list.dart';
import '../event_tracker.dart';
import '../reward_points_page.dart';

class DietRecorderPage extends StatefulWidget {
  const DietRecorderPage({super.key});

  @override
  _DietRecorderPageState createState() {
    return _DietRecorderPageState();
  }
}

class _DietRecorderPageState extends State<DietRecorderPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        body: ListView(
          children: [
            RewardPointsPage(),
            DietManager(),
            //EventTracker(context.watch<DietList>().getDietList(), 'DIET'),
            SingleChildScrollView(
              child: EventTracker('DIET'),
            )
          ],
        )
    );
  }
}