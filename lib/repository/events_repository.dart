import 'package:stay_fit/models/event.dart';

abstract class EventsRepository {
  Future<void> addEvent(Event event);
  Future<List<Event>> listByEventType(String eventType);
  Future<void> deleteEvent(Event event);
}