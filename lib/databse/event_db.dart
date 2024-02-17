
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/event_dao.dart';
import '../entity/event_entity.dart';

part 'event_db.g.dart';

@Database(version: 1, entities: [EventEntity])
abstract class EventDatabase extends FloorDatabase {
  EventsDao get eventsDao;
}