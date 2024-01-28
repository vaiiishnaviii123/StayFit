import 'package:flutter/material.dart';
import 'package:stay_fit/emotions/emoji_recorder.dart';
import 'package:stay_fit/event_tracker.dart';

import '../event.dart';

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
            EmojiRecorder(_addEmotionEvent),
            EventTracker(_emotionEvents),
          ],
        )
    );
  }
}