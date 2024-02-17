import 'package:stay_fit/models/event.dart';

abstract class EventsRepository {
  Future<void> addEvent(Event event);
  Future<List<Event>> listByEventType(String eventType);
  Future<void> deleteEvent(Event event);
  Future<List<String>> getMenuList(String eventType);
  Future<void> updateDietEvent(Event event);
  Future<int> getCountOfAllEvents(String eventType);
}