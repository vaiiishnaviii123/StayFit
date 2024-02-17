import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stay_fit/providers/events_view_model.dart';
import '../models/event.dart';

class ShowEmotionList extends StatelessWidget {
  final String eventType;
  const ShowEmotionList(this.eventType, {super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Event>> futureSpendingEvents = context.select<EventsViewModel, Future<List<Event>>>(
            (viewModel) => viewModel.listAllEvents(eventType)
    );
    return FutureBuilder(
      future: futureSpendingEvents,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final spendingEvents = snapshot.data!;
          return Column(
            children: spendingEvents.map((event) => ListTile(
              leading: Text('${event.id}'),
              title: Text(event.iformation),
              subtitle: Text('${event.amount}'),
              trailing: Text('${event.occurredOn}'),
            )).toList(),
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