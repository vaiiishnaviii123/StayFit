import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stay_fit/view/emotions/emoji_recorder.dart';
import 'package:stay_fit/view/event_tracker.dart';
import 'package:stay_fit/view/reward_points_page.dart';

class EmojiRecorderPage extends StatefulWidget {
  const EmojiRecorderPage({super.key});

  @override
  _EmojiRecorderPageState createState() {
    return _EmojiRecorderPageState();
  }
}

class _EmojiRecorderPageState extends State<EmojiRecorderPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Color.fromRGBO(191, 186, 188, 1),
        child: ListView(
          children: [
            RewardPointsPage(),
            EmojiRecorder(),
            SingleChildScrollView(
              child: EventTracker('EMOTION'),
            )
          ],
        )
    );
  }
}