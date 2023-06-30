import 'package:floor/floor.dart';

@entity
class StepsEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int count;
  final String time;

  StepsEntity({this.id, required this.count, required this.time});
}