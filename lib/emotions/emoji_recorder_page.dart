import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/emotions/emoji_recorder.dart';
import 'package:stay_fit/event_tracker.dart';
import 'package:stay_fit/Models/event.dart';
import 'package:stay_fit/reward_points.dart';
import 'package:stay_fit/reward_points_page.dart';

import '../event_emotions_list.dart';

class EmojiRecorderPage extends StatefulWidget {
  const EmojiRecorderPage({super.key});

  @override
  _EmojiRecorderPageState createState() {
    return _EmojiRecorderPageState();
  }
}

class _EmojiRecorderPageState extends State<EmojiRecorderPage> {
  final List<Event> _emotionEvents = [];

  _addEmotionEvent(Event event) {
    setState(() {
      _emotionEvents.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        // appBar: AppBar(
        //   backgroundColor: const Color.fromRGBO(82, 7, 39, 2),
        //   title: Center(
        //     child: Text(
        //       'Reward Points ${context.watch<RewardPoints>().getRewardPoints().rewardPoints}',
        //       style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        //     ),
        //   ),
        // ),
        body: ListView(
          children: [
            RewardPointsPage(),
            EmojiRecorder(_addEmotionEvent),
            EventTracker(context.watch<EmotionList>().getEmotionsList()),
          ],
        )
    );
  }
}