import 'package:flutter/material.dart';
import 'package:stay_fit/event.dart';

class EmojiRecorder extends StatefulWidget {
  final void Function(Event event) addEvent;
  const EmojiRecorder(this.addEvent, {super.key});

  @override
  _EmojiRecorderState createState() {
    return _EmojiRecorderState();
  }
}

class _EmojiRecorderState extends State<EmojiRecorder> {
  // final _formKey = GlobalKey<FormState>();
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
    "🤩": "You felt star strucked",
    "🤔": "You spent time thinkinbg about something",
    "🫡": "You admired someone ",
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

  void _onSavePressed(String str){
     Event event = Event(
          str,
          DateTime.now()
     );
     widget.addEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
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
            padding: const EdgeInsets.all(6),
            color: Colors.blueGrey,
            child:GestureDetector(
              onTap: (){
                _onSavePressed('$key, ${emojiExpressions[key]}');
              },
              child: Text(key, style: TextStyle(fontSize: 35)),
            ),
          );
        }).toList(),
      )
    );
  }
}

class EmotionTracker extends StatefulWidget {
  const EmotionTracker({super.key});

  @override
  _EmotionTrackerState createState() {
    return _EmotionTrackerState();
  }
}

class _EmotionTrackerState extends State<EmotionTracker> {

  var date = DateTime.now();
  var list = [
    ' 😀 You felt excited',
    ' 😋 You had delicious food'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.minHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  list.length, (index) => ItemWidget(text: list.elementAt(index), date: DateTime.now())),
            ),
          ),
        );
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.date,
  });

  final String text;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(173, 167, 153, 5),
      child: SizedBox(
        height: 60,
        child: Center(child: Text('  $text on ${date.day}-${date.month}-${date.year} at ${date.hour}-${date.minute}-${date.second}.')),
      ),
    );
  }
}

