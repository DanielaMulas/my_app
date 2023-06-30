// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stepsDB.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorStepsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$StepsDatabaseBuilder databaseBuilder(String name) =>
      _$StepsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$StepsDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$StepsDatabaseBuilder(null);
}

class _$StepsDatabaseBuilder {
  _$StepsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$StepsDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$StepsDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<StepsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$StepsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$StepsDatabase extends StepsDatabase {
  _$StepsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StepsDao? _stepsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `StepsEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `count` INTEGER NOT NULL, `time` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StepsDao get stepsDao {
    return _stepsDaoInstance ??= _$StepsDao(database, changeListener);
  }
}

class _$StepsDao extends StepsDao {
  _$StepsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _stepsEntityInsertionAdapter = InsertionAdapter(
            database,
            'StepsEntity',
            (StepsEntity item) => <String, Object?>{
                  'id': item.id,
                  'count': item.count,
                  'time': item.time
                }),
        _stepsEntityUpdateAdapter = UpdateAdapter(
            database,
            'StepsEntity',
            ['id'],
            (StepsEntity item) => <String, Object?>{
                  'id': item.id,
                  'count': item.count,
                  'time': item.time
                }),
        _stepsEntityDeletionAdapter = DeletionAdapter(
            database,
            'StepsEntity',
            ['id'],
            (StepsEntity item) => <String, Object?>{
                  'id': item.id,
                  'count': item.count,
                  'time': item.time
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StepsEntity> _stepsEntityInsertionAdapter;

  final UpdateAdapter<StepsEntity> _stepsEntityUpdateAdapter;

  final DeletionAdapter<StepsEntity> _stepsEntityDeletionAdapter;

  @override
  Future<List<StepsEntity>> findStepsbyDate(
    int id,
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Steps WHERE id = ?1 AND dateTime between ?2 AND ?3 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => StepsEntity(id: row['id'] as int?, count: row['count'] as int, time: row['time'] as String),
        arguments: [
          id,
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<StepsEntity>> findAllSteps() async {
    return _queryAdapter.queryList('SELECT * FROM Steps',
        mapper: (Map<String, Object?> row) => StepsEntity(
            id: row['id'] as int?,
            count: row['count'] as int,
            time: row['time'] as String));
  }

  @override
  Future<List<StepsEntity>> _findSpecificDaySteps(DateTime time) async {
    return _queryAdapter.queryList('SELECT * FROM Steps WHERE dateTime == ?1',
        mapper: (Map<String, Object?> row) => StepsEntity(
            id: row['id'] as int?,
            count: row['count'] as int,
            time: row['time'] as String),
        arguments: [_dateTimeConverter.encode(time)]);
  }

  @override
  Future<List<StepsEntity>> _findLastHourSteps(DateTime time) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Steps WHERE and dateTime >= ?1 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => StepsEntity(
            id: row['id'] as int?,
            count: row['count'] as int,
            time: row['time'] as String),
        arguments: [_dateTimeConverter.encode(time)]);
  }

  @override
  Future<void> insertStep(StepsEntity steps) async {
    await _stepsEntityInsertionAdapter.insert(steps, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSteps(StepsEntity step) async {
    await _stepsEntityUpdateAdapter.update(step, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteSteps(StepsEntity step) async {
    await _stepsEntityDeletionAdapter.delete(step);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
