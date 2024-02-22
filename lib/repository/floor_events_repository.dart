import 'package:stay_fit/databse/event_db.dart';
import 'package:stay_fit/entity/event_entity.dart';
import 'package:stay_fit/repository/events_repository.dart';

import '../models/event.dart';

class FloorEventsRepository implements EventsRepository {
  EventDatabase _database;

  FloorEventsRepository(this._database);

  EventDatabase get database => _database;

  @override
  Future<void> addEvent(Event event) async {
    EventEntity entity = EventEntity(
        null,
        event.iformation,
        event.occurredOn.millisecondsSinceEpoch,
        event.amount,
        event.eventType
    );
    await _database.eventsDao.addEvent(entity);
  }

  @override
  Future<List<Event>> listByEventType(String eventType) async {
    final entities = await _database.eventsDao.listByEventType(eventType);
    return entities.map(_convertFromDatabase).toList();
  }

  Event _convertFromDatabase(EventEntity entity) => Event(
      entity.id,
      entity.information,
      DateTime.fromMillisecondsSinceEpoch(entity.occurredOn),
      entity.eventType,
      entity.amount,
  );

  @override
  Future<void> deleteEvent(Event event) async {
    print('delete pressed repo');
    EventEntity entity = EventEntity(
        event.id,
        event.iformation,
        event.occurredOn.millisecondsSinceEpoch,
        event.amount,
        event.eventType
    );
    await _database.eventsDao.deleteEvent(entity);
  }

  @override
  Future<List<String>> getMenuList(String eventType) async {
    final entities = await _database.eventsDao.getMenuList(eventType);
    return entities.toList();
  }

  @override
  Future<void> updateDietEvent(Event event) async {
    print('update pressed repo');
    EventEntity entity = EventEntity(
        event.id,
        event.iformation,
        event.occurredOn.millisecondsSinceEpoch,
        event.amount,
        event.eventType
    );
    await _database.eventsDao.updateDietEvent(entity);
  }

  @override
  Future<int> getCountOfAllEvents(String eventType) async {
    Future<int?> futureCount = _database.eventsDao.getCountOfEvents(eventType);
    int? count = await futureCount;
    return count ?? 0;
  }
}