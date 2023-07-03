import 'package:floor/floor.dart'; 
import 'package:my_app/database/entities/stepsEntity.dart'; 

@dao
abstract class StepsDao{
  // Select entries of Steps table of a certain date 
  @Query('SELECT * FROM Steps WHERE id = :id AND dateTime between :startTime AND :endTime ORDER BY dateTime ASC')
  Future<List<StepsEntity>> findStepsbyDate(int id,DateTime startTime,DateTime endTime);

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
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSteps(StepsEntity step);

  //Select a specific day
  @Query('SELECT * FROM Steps WHERE dateTime == :time')
  Future<List<StepsEntity>> findSpecificDaySteps(DateTime time);

  //SELECT last steps
  @Query('SELECT * FROM Steps WHERE and dateTime >= :time ORDER BY dateTime ASC')
  Future<List<StepsEntity>> _findLastHourSteps(DateTime time);

  Future<List<StepsEntity>> findLastHourSteps() {
     final time = DateTime.now().subtract(const Duration(hours: 1));
     return _findLastHourSteps(time);
}
}//StepsDao
