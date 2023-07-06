import 'package:my_app/database/stepsDB.dart';
import 'package:my_app/database/entities/stepsEntity.dart';
import 'package:flutter/material.dart';


class DatabaseRepository extends ChangeNotifier{

  //The state of the database is just the AppDatabase
  final StepsDatabase database;

  //Default constructor
  DatabaseRepository({required this.database});

  
  Future<List<StepsEntity>> findAllSteps() async{
    final results = await database.stepsDao.findAllSteps();
    return results;
  }//findAllSteps

  Future<List<StepsEntity>> findStepsbyRange(int id, DateTime startDay, DateTime endDay) async{
    final results = await database.stepsDao.findStepsbyRange(id,startDay,endDay);
    return results;
  }
  Future<List<StepsEntity>> findSpecificDaySteps(DateTime day) async{
    final results = await database.stepsDao.findSpecificDaySteps(day);
    return results;
  }
 
  Future<void> insertStep(StepsEntity step)async {
    await database.stepsDao.insertStep(step);
    notifyListeners();
  }//insertStep

  //This method wraps the deleteTodo() method of the DAO. 
  //Then, it notifies the listeners that something changed.
  Future<void> removeSteps(StepsEntity step) async{
    await database.stepsDao.deleteSteps(step);
    notifyListeners();
  }//removeStep

  //Update a Steps entry
  /*Future<void> updateSteps(StepsEntity step) async {
    await database.stepsDao.updateSteps(step);
    notifyListeners();
  }*/

 

  
}//DatabaseRepository