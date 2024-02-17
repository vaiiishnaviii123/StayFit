import 'package:flutter/material.dart';
import 'package:stay_fit/emotions/emoji_recorder.dart';
import 'package:stay_fit/entity/show_emotion_list.dart';
import 'package:stay_fit/event_tracker.dart';
import 'package:stay_fit/reward_points_page.dart';

class EmojiRecorderPage extends StatefulWidget {
  const EmojiRecorderPage({super.key});

  @override
  _EmojiRecorderPageState createState() {
    return _EmojiRecorderPageState();
  }
}

class _EmojiRecorderPageState extends State<EmojiRecorderPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        body: ListView(
          children: [
            RewardPointsPage(),
            EmojiRecorder(),
            //EventTracker(context.watch<EmotionList>().getEmotionsList(), 'EMOTION'),
            SingleChildScrollView(
              child: EventTracker('EMOTION'),
            )
          ],
        )
    );
  }
}