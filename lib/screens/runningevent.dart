import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/screens/authorizationpage.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';

class RunEvent extends StatefulWidget {
  const RunEvent({Key? key}) : super(key: key);

  static const route = '/runningevent/';
  static const routeDisplayName = 'RunEvent';

  @override
  State<RunEvent> createState() => _RunEventState();
}

class _RunEventState extends State<RunEvent> {
  Timer? timer;
  int totalTime = 30; //Total time in seconds
  int currentTime = 0; //Current time in seconds
  bool isRunning = false; //Indicates if the timer is running

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    //checking if isRunning is false
    if (isRunning == false) {
      setState(() {
        currentTime = 0; // Reset the current time
        isRunning = true;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {//
        setState(() {
          if (currentTime < totalTime) {
            currentTime++;
          } else {
            timer.cancel();
            isRunning = false;
          }
        });
      });
    }else{
      timer?.cancel();
      setState(() {
        isRunning = false;
      });
    }
  }

  double _timeLeftPercentage() {
    return currentTime / totalTime;
  }

  String _timeLeft() {
    final remainingSeconds = totalTime - currentTime;
    final minutes = (remainingSeconds / 60).floor();
    final seconds = remainingSeconds % 60;
    final secondsString =
        seconds < 10 ? '0$seconds' : '$seconds'; //if it is <10 --> 01,02,...,09
    return '$minutes:$secondsString';
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
                onPressed: _startTimer,
                child: Text(isRunning ? 'Timer Running' : 'Participate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

