import 'package:flutter/material.dart';

class Event {
   int? id;
   String iformation; // emoji / dish / exercise
   DateTime occurredOn;
   String eventType;
   double? amount;

  Event(this.id, this.iformation, this.occurredOn, this.eventType, this.amount);
}
