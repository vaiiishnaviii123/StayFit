import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/models/event.dart';
import 'package:stay_fit/providers/events_view_model.dart';

class EventTracker extends StatelessWidget {
  final String _type;
  const EventTracker(this._type, {super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Event>> futureEvents = context.select<EventsViewModel, Future<List<Event>>>(
            (viewModel) => viewModel.listAllEvents(_type)
    );
    return FutureBuilder(
      future: futureEvents,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final events = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
                events.length, (index) => EventTrackerCard(events.elementAt(index))
            ),
          );
        } else if(snapshot.hasError) {
          return const Text('An error occurred trying to load your data and we have no idea what to do about it. Sorry.');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class EventTrackerCard extends StatefulWidget {
  Event _event;
  EventTrackerCard(this._event, {super.key});

  @override
  _EventTrackerCardState createState() => _EventTrackerCardState();

}
class _EventTrackerCardState extends State<EventTrackerCard> {

  void deleteEvent(Event event){
    print('delete pressed');
    context.read<EventsViewModel>().deleteEvent(event);
  }
  @override
  Widget build(BuildContext context) {
    String str = '';
    if(widget._event.eventType == 'WORKOUT'){
      str = 'Workout Type: '+ widget._event.iformation + ',  Reps: ' + widget._event.amount.toString();
    }
    else if(widget._event.eventType == 'DIET'){
      str = 'Dish: '+ widget._event.iformation + ', Quantity: ' + widget._event.amount.toString() +' grams';
    }
    else{
        str = widget._event.iformation;
    }
    return Card(
      color: Color.fromRGBO(173, 167, 153, 5),
      child: SizedBox(
        key: Key("card"),
        height: 60,
        child: Center(
            child: ListTile(
              leading: Text('${widget._event.id}'),
              title: Text('$str on ${widget._event.occurredOn}', style: TextStyle(fontSize: 12),),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('delete pressed');
                  deleteEvent(widget._event);
                },
              ),
            )
        ),
      ),
    );
  }

}