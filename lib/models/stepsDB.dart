import 'package:flutter/material.dart';
import 'package:my_app/models/steps.dart';

class StepsDB extends ChangeNotifier{
  List<Steps> stepsData=[];

  void updateSteps(Steps step) {
    stepsData.add(step);
    notifyListeners();

  }
}