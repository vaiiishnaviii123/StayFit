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
                  _event.length, (index) => Card(
                color: Color.fromRGBO(173, 167, 153, 5),
                child: SizedBox(
                  height: 60,
                  child: Center(child: Text('  ${_event.elementAt(index).text} on ${_event.elementAt(index).date.day}-${_event.elementAt(index).date.month}-${_event.elementAt(index).date.year} at ${_event.elementAt(index).date.hour}-${_event.elementAt(index).date.minute}-${_event.elementAt(index).date.second}.')),
                ),
              ),
              ),
            ),
          ),
        );
      }),
    );
  }
}