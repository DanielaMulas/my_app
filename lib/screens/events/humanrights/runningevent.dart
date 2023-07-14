import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/models/authorization.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/screens/stats.dart';

class TimerData extends ChangeNotifier {
  int totalTime = 24; // Total time in seconds (mimicking hours: *60*60)
  int currentTime = 0; // Current time in seconds
  bool isRunning = false; // To check if the timer is running
  bool isTimerDisabled = false; // To check if the timer is disabled

  int? totalSteps;
  final int maxSteps = 9000; // StepGoal

  final Authorization auth = Authorization();

  late DateTime chosenDay;
  Timer? timer;

  int points = 600;
  //

  TimerData(BuildContext context, DateTime day) {
    chosenDay = day;
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
  } //_loadTimerData

  void _saveTimerData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timer', currentTime);
    await prefs.setBool('isRunning', isRunning);
  } //_saveTimerData

  void _startTimer(BuildContext context) async {
    if (isRunning == false) {
      isRunning = true;
      isTimerDisabled = true;
      _saveTimerData();

      auth.requestDataSingleDay(context, chosenDay).then((steps) {
        totalSteps = steps?.fold<int>(0, (sum, step) => sum + step.value);
        print('$totalSteps');
        notifyListeners();
      });
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentTime < totalTime) {
        currentTime++;
        _saveTimerData();
      } else {
        _stopTimer(context);
      }

      notifyListeners();
    });
  } //_startTimer

  bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year &&
        day1.month == day2.month &&
        day1.day == day2.day;
  }

  void addPoints(BuildContext context) {
    final pointsData = Provider.of<PointsData>(context, listen: false);
    pointsData.addPoints(100);
  }

  void _stopTimer(BuildContext context) {
    isRunning = false;
    isTimerDisabled = true;
    addPoints(context);

    timer?.cancel();
    timer = null;
    notifyListeners();
  } //_stopTimer

  double timeLeftPercentage() {
    return currentTime / totalTime;
  } //timeLeftPercentage

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
    final selectedDay = DateTime(2023, 7, 17);
    return ChangeNotifierProvider(
      create: (context) => TimerData(context, selectedDay),
      child: _RunEventPage(),
    );
  }
}

class _RunEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerData = Provider.of<TimerData>(context);

    Widget _returnStepsText() {
      if (timerData.currentTime >= timerData.totalTime &&
          timerData.totalSteps != null &&
          timerData.maxSteps <= timerData.totalSteps!) {
        return Text(
          'Congratulations! You have completed the task by taking ${timerData.totalSteps} steps',
          style: const TextStyle(fontSize: 19),
        );
      } else if (timerData.totalSteps != null &&
          timerData.totalSteps! < timerData.maxSteps) {
        return const Text("Sorry, you didn't make it. Try next time!",
            style: TextStyle(fontSize: 19));
      } else {
        return const Text('Start now!', style: TextStyle(fontSize: 20));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's start!"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
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
              const Text(
                'Press the button to partecipate!',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 90, 34),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 47, 149, 37),
                height: 5,
                thickness: 3,
                indent: 20,
                endIndent: 20,
              ),
              const SizedBox(height: 50),
              const Text(
                'Time Left:',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 32, 90, 34),
                ),
              ),
              const SizedBox(height: 30),
              LinearPercentIndicator(
                padding: const EdgeInsets.only(left: 40),
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: timerData.isTimerDisabled ||
                        !timerData.isSameDay(timerData.chosenDay,
                            DateTime.now().subtract(const Duration(days: 1)))
                    ? null
                    : () {
                        timerData._startTimer(context);
                      },
                child:
                    Text(timerData.isRunning ? 'Timer Running' : 'Participate'),
              ),
              const SizedBox(height: 30.0),
              if (timerData.currentTime >= timerData.totalTime)
                _returnStepsText(),
            ],
          ),
        ),
      ),
    );
  }
}
