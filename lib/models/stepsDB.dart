import 'dart:async';
import 'package:floor/floor.dart';
import 'package:my_app/models/steps_dao.dart';
import 'package:my_app/models/entities.dart';
import 'package:my_app/models/typeConverters.dart';
import 'package:sqflite/sqflite.dart' as sqflite;



part 'stepsDB.g.dart';

//Here, we are importing the entities and the daos of the database

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [StepsEntity])
abstract class StepsDatabase extends FloorDatabase{
  StepsDao get stepsDao;
}
