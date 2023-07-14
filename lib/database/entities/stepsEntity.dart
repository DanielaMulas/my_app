import 'package:floor/floor.dart';


@entity
class StepsEntity {
  @PrimaryKey()
  final String day;
  final int value;

  StepsEntity({required this.day, required this.value});
}