// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorEventDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EventDatabaseBuilder databaseBuilder(String name) =>
      _$EventDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EventDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$EventDatabaseBuilder(null);
}

class _$EventDatabaseBuilder {
  _$EventDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$EventDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EventDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EventDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$EventDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EventDatabase extends EventDatabase {
  _$EventDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EventsDao? _eventsDaoInstance;

  RewardsDao? _rewardsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Events` (`id` INTEGER, `information` TEXT NOT NULL, `occurredOn` INTEGER NOT NULL, `amount` REAL, `eventType` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Rewards` (`id` INTEGER, `rewardPoints` REAL NOT NULL, `dedication` INTEGER NOT NULL, `event` TEXT NOT NULL, `occuredOn` INTEGER NOT NULL, `pointForNextLevel` REAL NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EventsDao get eventsDao {
    return _eventsDaoInstance ??= _$EventsDao(database, changeListener);
  }

  @override
  RewardsDao get rewardsDao {
    return _rewardsDaoInstance ??= _$RewardsDao(database, changeListener);
  }
}

class _$EventsDao extends EventsDao {
  _$EventsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _eventEntityInsertionAdapter = InsertionAdapter(
            database,
            'Events',
            (EventEntity item) => <String, Object?>{
                  'id': item.id,
                  'information': item.information,
                  'occurredOn': item.occurredOn,
                  'amount': item.amount,
                  'eventType': item.eventType
                }),
        _eventEntityUpdateAdapter = UpdateAdapter(
            database,
            'Events',
            ['id'],
            (EventEntity item) => <String, Object?>{
                  'id': item.id,
                  'information': item.information,
                  'occurredOn': item.occurredOn,
                  'amount': item.amount,
                  'eventType': item.eventType
                }),
        _eventEntityDeletionAdapter = DeletionAdapter(
            database,
            'Events',
            ['id'],
            (EventEntity item) => <String, Object?>{
                  'id': item.id,
                  'information': item.information,
                  'occurredOn': item.occurredOn,
                  'amount': item.amount,
                  'eventType': item.eventType
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EventEntity> _eventEntityInsertionAdapter;

  final UpdateAdapter<EventEntity> _eventEntityUpdateAdapter;

  final DeletionAdapter<EventEntity> _eventEntityDeletionAdapter;

  @override
  Future<List<EventEntity>> listByEventType(String eventType) async {
    return _queryAdapter.queryList('SELECT * FROM Events WHERE eventType = ?1',
        mapper: (Map<String, Object?> row) => EventEntity(
            row['id'] as int?,
            row['information'] as String,
            row['occurredOn'] as int,
            row['amount'] as double?,
            row['eventType'] as String),
        arguments: [eventType]);
  }

  @override
  Future<List<String>> getMenuList(String eventType) async {
    return _queryAdapter.queryList(
        'SELECT information FROM Events WHERE eventType = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [eventType]);
  }

  @override
  Future<int?> getCountOfEvents(String eventType) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM Events WHERE eventType > ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [eventType]);
  }

  @override
  Future<void> addEvent(EventEntity event) async {
    await _eventEntityInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDietEvent(EventEntity event) async {
    await _eventEntityUpdateAdapter.update(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEvent(EventEntity event) async {
    await _eventEntityDeletionAdapter.delete(event);
  }
}

class _$RewardsDao extends RewardsDao {
  _$RewardsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _rewardEntityInsertionAdapter = InsertionAdapter(
            database,
            'Rewards',
            (RewardEntity item) => <String, Object?>{
                  'id': item.id,
                  'rewardPoints': item.rewardPoints,
                  'dedication': item.dedication,
                  'event': item.event,
                  'occuredOn': item.occuredOn,
                  'pointForNextLevel': item.pointForNextLevel
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RewardEntity> _rewardEntityInsertionAdapter;

  @override
  Future<RewardEntity?> getLastRecord() async {
    return _queryAdapter.query('SELECT * FROM Rewards ORDER BY id DESC LIMIT 1',
        mapper: (Map<String, Object?> row) => RewardEntity(
            row['id'] as int?,
            row['rewardPoints'] as double,
            row['dedication'] as int,
            row['event'] as String,
            row['occuredOn'] as int,
            row['pointForNextLevel'] as double));
  }

  @override
  Future<void> addReward(RewardEntity reward) async {
    await _rewardEntityInsertionAdapter.insert(
        reward, OnConflictStrategy.abort);
  }
}
