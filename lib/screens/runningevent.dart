import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/screens/authorizationpage.dart';
import 'package:my_app/';

class RunEvent extends StatefulWidget {
  const RunEvent({Key? key}) : super(key: key);

  static const route = '/runningevent/';
  static const routeDisplayName = 'RunEvent';

  @override
  State<RunEvent> createState() => _RunEventState();
}

class _RunEventState extends State<RunEvent> {
  final currentStep = 0;
  final totalSteps = 0;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
        ),
        body: const Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }

 
}