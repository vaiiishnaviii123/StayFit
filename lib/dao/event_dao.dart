import 'package:floor/floor.dart';
import 'package:stay_fit/entity/event_entity.dart';

@dao
abstract class EventsDao {
  @insert
  Future<void> addEvent(EventEntity event);

  @Query('SELECT * FROM Events WHERE eventType = :eventType')
  Future<List<EventEntity>> listByEventType(String eventType);

  @delete
  Future<void> deleteEvent(EventEntity event);

  @Query('SELECT information FROM Events WHERE eventType = :eventType')
  Future<List<String>> getMenuList(String eventType);
}