import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/emotions/emoji_recorder.dart';
import 'package:stay_fit/event_tracker.dart';
import 'package:stay_fit/reward_points_page.dart';
import '../providers/event_emotions_list.dart';

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
            EventTracker(context.watch<EmotionList>().getEmotionsList()),
          ],
        )
    );
  }
}