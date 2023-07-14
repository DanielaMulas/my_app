import 'package:floor/floor.dart';

/*@entity
class StepsEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int value; 
  final String day;

  StepsEntity({this.id, required this.value, required this.day});


}*/



@entity
class StepsEntity {
  @PrimaryKey()
  final String day;
  final int value;

  StepsEntity({required this.day, required this.value});
}