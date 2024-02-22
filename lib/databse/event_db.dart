
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:stay_fit/dao/rewards_activity_dao.dart';
import 'package:stay_fit/entity/reward_entity.dart';

import '../dao/event_dao.dart';
import '../entity/event_entity.dart';

part 'event_db.g.dart';

@Database(version: 1, entities: [EventEntity, RewardEntity])
abstract class EventDatabase extends FloorDatabase {
  EventsDao get eventsDao;
  RewardsDao get rewardsDao;
}