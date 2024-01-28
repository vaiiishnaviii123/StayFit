import 'package:flutter/material.dart';
import 'package:stay_fit/emoji_recorder.dart';
import 'package:stay_fit/event_tracker.dart';

import 'event.dart';

class EmojiRecorderPage extends StatefulWidget {
  const EmojiRecorderPage({super.key});

  @override
  _EmojiRecorderPageState createState() {
    return _EmojiRecorderPageState();
  }
}

class _EmojiRecorderPageState extends State<EmojiRecorderPage> {
  final List<Event> _events = [];

  _addEvent(Event event) {
    setState(() {
      _events.add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
            EmojiRecorder(_addEvent),
            EventTracker(_events),
          ],
        )
    );
  }
}