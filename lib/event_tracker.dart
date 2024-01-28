import 'package:flutter/material.dart';
import 'package:stay_fit/event.dart';

class EventTracker extends StatelessWidget {
  final List<Event> _event;
  const EventTracker(this._event, {super.key});

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
                  _event.length, (index) => ItemWidget(text: '${_event.elementAt(index).text}', date: _event.elementAt(index).date)
              ),
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
