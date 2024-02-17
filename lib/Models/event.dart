import 'package:flutter/material.dart';

class Event {
  final int? id;
  final String iformation; // emoji / dish / exercise
  final DateTime occurredOn;
  final String eventType;
  final double? amount;

  Event(this.id, this.iformation, this.occurredOn, this.eventType, this.amount);
}
