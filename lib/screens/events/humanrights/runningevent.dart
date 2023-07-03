import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/models/authorization.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RunEvent1 extends StatefulWidget {
  const RunEvent1({Key? key}) : super(key: key);

  static const route = '/runningevent/';
  static const routeDisplayName = 'RunEvent';

  @override
  State<RunEvent1> createState() => _RunEventState();
}

class _RunEventState extends State<RunEvent1> {

  Timer? timer;
  int totalTime = 24; // Total time in seconds (mimicking hours)
  int currentTime = 0; // Current time in seconds
  bool isRunning = false; // Checking if the timer is running
  bool isTimerDisabled = false; // CHecking if the timer is disabled
  int? totalSteps; 
  final int maxSteps = 9000; // StepGoal

  final Authorization auth = Authorization();

  DateTime day = DateTime.now().subtract(const Duration(days: 1)); // Initialized as "yesterday"
  String formattedDayDisplay = DateFormat('dd-MM-yyyy').format(DateTime.now().subtract(const Duration(days: 1)));

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() async {
    if (isRunning) {
      setState(() {
        timer?.cancel();
        isRunning = false;
      });
    } else {
      setState(() {
        currentTime = 0; // Resetting the timer
        isRunning = true;
        isTimerDisabled = true;
        auth.requestDataSingleDay(context, day).then((steps) {
          setState(() {
            totalSteps = steps?.fold<int>(0, (sum, step) => sum + step.value);
            print('$totalSteps');
          });
        });
      });
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (currentTime < totalTime) {
          currentTime++;
        } else {
          timer.cancel();
          isRunning = false;
          isTimerDisabled = true;          
        }
      });
    });
  }

  double _timeLeftPercentage() {
    return currentTime / totalTime;
  }

  String _timeLeft() {
    final remainingSeconds = totalTime - currentTime;
    final minutes = (remainingSeconds / 60).floor();
    final seconds = remainingSeconds % 60;
    final secondsString = seconds < 10 ? '0$seconds' : '$seconds'; // If it is <10 --> 01,02,...,09
    return '$minutes:$secondsString';
  }

  Widget _returnStepsText(){
    if(totalSteps != null && totalSteps! >= maxSteps){
      return Text('Congratulations! You have completed the task by taking ${totalSteps} steps');
    }
    else if(totalSteps != null && totalSteps! < maxSteps){
      return Text("Sorry, you didn't make it. Try again!");
    }
    else{
      return Text('Start now!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's start!"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                'Time Left:',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 32, 90, 34),
                ),
              ),
              const SizedBox(height: 20),
              LinearPercentIndicator(
                width: 300,
                lineHeight: 20.0,
                percent: _timeLeftPercentage(),
                center: Text(
                  _timeLeft(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                progressColor: Colors.green,
                backgroundColor: const Color.fromARGB(255, 106, 238, 113),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isTimerDisabled ? null: _startTimer, //If isTimerDisabled is true, then onPressed is null. Otherwise, it launches _startTimer
                child: Text(isRunning ? 'Timer Running' : 'Participate'),
              ),
              SizedBox(height: 15.0),
              if(currentTime >= totalTime) _returnStepsText(),
              
            ],
          ),
        ),
      ),
    );
  }
}