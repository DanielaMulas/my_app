import 'package:floor/floor.dart'; 
import 'package:my_app/database/entities/stepsEntity.dart'; 

@dao
abstract class StepsDao{
  // Select entries of Steps table of a certain date 
  @Query('SELECT * FROM Steps WHERE id = :id AND dateTime between :startDay AND :endDay ORDER BY dateTime ASC')
  Future<List<StepsEntity>> findStepsbyRange(int id, DateTime startDay, DateTime endDay);

  //Select a specific day
  @Query('SELECT * FROM Steps WHERE dateTime == :day')
  Future<List<StepsEntity>> findSpecificDaySteps(DateTime day);

  // Obtain all the entries
  @Query('SELECT * FROM Steps')
  Future<List<StepsEntity>> findAllSteps();

  //Insert Steps in the table
  @insert
  Future<void> insertStep(StepsEntity steps);

  //Delete a Step from the table
  @delete
  Future<void> deleteSteps(StepsEntity step);

  //Update a Steps entry
  /*@Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSteps(StepsEntity step);*/

  

  
}//StepsDao
