import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/models/authorization.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerData with ChangeNotifier {
  int totalTime = 24; // Total time in seconds (mimicking hours)
  int currentTime = 0; // Current time in seconds
  bool isRunning = false; // Checking if the timer is running
  bool isTimerDisabled = false; // Checking if the timer is disabled

  int? totalSteps;
  final int maxSteps = 9000; // StepGoal

  final Authorization auth = Authorization();

  DateTime day = DateTime.now()
      .subtract(const Duration(days: 1)); // Initialized as "yesterday"
  String formattedDayDisplay = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().subtract(const Duration(days: 1)));

  Timer? timer;

  TimerData(BuildContext context) {
    _loadTimerData(context);
  }

  void _loadTimerData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final storedTime = prefs.getInt('timer');
    final isRunning = prefs.getBool('isRunning') ?? false;
    if (storedTime != null && isRunning) {
      currentTime = storedTime;
      isTimerDisabled = true;
      _startTimer(context);
    }
  }//_loadTimerData

  void _saveTimerData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timer', currentTime);
    await prefs.setBool('isRunning', isRunning);
  }//_saveTimerData

  void _startTimer(BuildContext context) async {
    if (isRunning == false) {
      isRunning = true;
      isTimerDisabled = true;
      _saveTimerData();

      auth.requestDataSingleDay(context, day).then((steps) {
        totalSteps = steps?.fold<int>(0, (sum, step) => sum + step.value);
        print('$totalSteps');
        notifyListeners();
      });
    };
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTime < totalTime) {
        currentTime++;
        _saveTimerData();
      } else {
        _stopTimer();
      }
      notifyListeners();
    });
    
  }//_startTimer

  void _stopTimer() {
    isRunning = false;
    isTimerDisabled = true;
    _saveTimerData();

    timer?.cancel();
    timer = null;
    notifyListeners();
  }//_stopTimer

  double timeLeftPercentage() {
    return currentTime / totalTime;
  }//timeLeftPercentage

  String timeLeft() {
    final remainingSeconds = totalTime - currentTime;
    final minutes = (remainingSeconds / 60).floor();
    final seconds = remainingSeconds % 60;
    final secondsString = seconds < 10 ? '0$seconds' : '$seconds';
    return '$minutes:$secondsString';
  }
}

class RunEvent1 extends StatelessWidget {
  const RunEvent1({Key? key}) : super(key: key);

  static const route = '/runningevent/';
  static const routeDisplayName = 'RunEvent';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerData(context),
      child: _RunEventPage(),
    );
  }
}

class _RunEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerData = Provider.of<TimerData>(context);

    Widget _returnStepsText() {
      if (timerData.currentTime >= timerData.totalTime) {
        return Text(
          'Congratulations! You have completed the task by taking ${timerData.totalSteps} steps',
        );
      } else if (timerData.totalSteps != null &&
          timerData.totalSteps! < timerData.maxSteps) {
        return Text("Sorry, you didn't make it. Try again!");
      } else {
        return Text('Start now!');
      }
    }

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
                percent: timerData.timeLeftPercentage(),
                center: Text(
                  timerData.timeLeft(),
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
                onPressed: timerData.isTimerDisabled
                    ? null
                    : () {
                        timerData._startTimer(context);
                      },
                child:
                    Text(timerData.isRunning ? 'Timer Running' : 'Participate'),
              ),
              SizedBox(height: 15.0),
              if (timerData.currentTime >= timerData.totalTime)
                _returnStepsText(),
            ],
          ),
        ),
      ),
    );
  }
}
