import 'package:floor/floor.dart'; 
import 'package:my_app/database/entities/stepsEntity.dart'; 

@dao
abstract class StepsDao{
  // Select entries of Steps table of a certain date 

  /*@Query('SELECT * FROM Steps WHERE id = :id AND dateTime between :startTime AND :endTime ORDER BY dateTime ASC')
  Future<List<StepsEntity>> findStepsbyDate(int id,DateTime startTime,DateTime endTime);*/

  // Obtain all the entries
  @Query('SELECT * FROM StepsEntity')
  Future<List<StepsEntity>> findAllSteps();

  //Select the average value of steps
  @Query('SELECT AVG(value) FROM StepsEntity WHERE day >= :startDate AND day <= :endDate AND value IS NOT NULL')
  Future<double?> findStepsMean(DateTime startDate, DateTime endDate);

  //Insert Steps in the table
  @insert
  Future<void> insertStep(StepsEntity steps);

  //Delete a Step from the table
  @delete
  Future<void> deleteSteps(StepsEntity step);

  //Update a Steps entry

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSteps(StepsEntity step);

  //Select a specific day
  /*@Query('SELECT * FROM Steps WHERE dateTime == :time')
  Future<List<StepsEntity>> findSpecificDaySteps(DateTime time);


  


  Future<List<StepsEntity>> findLastHourSteps() {
     final time = DateTime.now().subtract(const Duration(hours: 1));
     return _findLastHourSteps(time);
}*/



}//StepsDao
