import 'package:floor/floor.dart';

@Entity(tableName: "Events")
class EventEntity {
  @primaryKey
  final int? id;
  final String information;
  final int occurredOn;
  final double? amount;
  final String eventType;

  EventEntity(this.id, this.information, this.occurredOn, this.amount, this.eventType);
}