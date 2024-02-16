import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/event.dart';
import 'package:stay_fit/providers/reward_points.dart';

import '../providers/event_emotions_list.dart';


class EmojiRecorder extends StatefulWidget {
  const EmojiRecorder({super.key});

  @override
  _EmojiRecorderState createState() {
    return _EmojiRecorderState();
  }
}

class _EmojiRecorderState extends State<EmojiRecorder> {
  final TextEditingController emojiController = TextEditingController();

  final Map<String, String> emojiExpressions = {
    "😀": "You felt excited",
    "😋": "You had delicious food",
    "🥰": "You are feeling loved",
    "🤣": "You spent a day laughing out louder",
    "😇": "You Feel blessed",
    "😊": "Your day was pleasant",
    "😎": "You are proud of yourself",
    "🤗": "You felt welcomed ",
    "🥳": "You are in mood of celebration",
    "🤩": "You felt star struck",
    "🤔": "You spent time thinking about something",
    "😏": "You make smirking face",
    "🤬": "You felt angry",
    "😠": "You felt annoyed",
    "🤐": "You were speechless",
    "🤢": "You were sick",
    "🤕": "Having a headache",
    "😞": "You felt sad ",
    "😥": "You felt tensed",
    "🥱": "You felt bored",
    "😴": "You felt sleepy",
    "😭": "You felt like crying",
    "🙄": "You felt weird",
    "😯": "You felt surprised ",
    "🤯": "You got a mind blowing idea",
  };
  double points = 0.0;
  int dedicationLevel = 0;

  void _onSavePressed(String str){
     Event event = Event(
          str,
          DateTime.now()
     );
     context.read<RewardPoints>().setEvent('Emotions');
     context.read<RewardPoints>().calcDedicationAndPoints();
     context.read<EmotionList>().addEmotionsToList(event);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SingleChildScrollView(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.all(30),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 5,
        children: emojiExpressions.keys.map((String key){
          return Container(
            color: Colors.blueGrey,
            child: Center(
            child:GestureDetector(
              key: Key(key),
              onTap: (){
                _onSavePressed('$key, ${emojiExpressions[key]}');
              },
              child: Text(key, style: TextStyle(fontSize: 35)),
            ),
            ),
          );
        }).toList(),
      )
    );
  }
}