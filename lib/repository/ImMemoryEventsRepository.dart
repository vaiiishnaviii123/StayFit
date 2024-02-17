
import 'package:stay_fit/models/event.dart';

import 'events_repository.dart';

class InMemoryEventsRepository implements EventsRepository {
  final List<Event> _events = [];

  @override
  Future<void> addEvent(Event event) async {
    _events.add(event);
  }

  @override
  Future<List<Event>> listByEventType(String eventType) async {
    return _events.where((event) => event.eventType == eventType).toList();
  }

  @override
  Future<void> deleteEvent(Event event) async {
    // TODO: implement deleteEvent
    _events.remove(event);
  }
}