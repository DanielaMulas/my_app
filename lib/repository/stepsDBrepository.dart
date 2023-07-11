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


  Future<double?> findStepsMean() async{
    DateTime now=DateTime.now();
    DateTime nowMidnight=DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime nowBM=DateTime(now.year, now.month, now.day, 23, 59, 59);
    String startDate = nowMidnight.subtract(const Duration(days: 7)).toString();
    String endDate = nowBM.subtract(const Duration(days: 1)).toString();

    final mean=await database.stepsDao.findStepsMean(startDate, endDate);

    /*if (mean != null) {
    return mean;
    } else {
      // Handle the case when the mean is null
      return null; 
    }*/
    return mean;
  }

  Future<int?> findStepsMax() async{
    final max=await database.stepsDao.findStepsMax();
    return max;
  }

  Future<int?> findStepsMin() async{
    final min=await database.stepsDao.findStepsMin();
    return min;
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


  /*Future<List<StepsEntity>> findLastHourSteps() async {
    final results = await database.stepsDao.findLastHourSteps();
    return results;
  }*/

  
  
 

  
}//DatabaseRepository