import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Steps{
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }//toString
}//Steps


/*class StepProvider extends ChangeNotifier {
  List<Steps> _stepsData = [];

  List<Steps> get stepsData => _stepsData;

  void updateSteps(List<Steps> steps) {
    _stepsData = steps;
    notifyListeners();
  }
}*/
