import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/models/userprofile.dart';
import 'package:my_app/screens/profilepage.dart';
import 'package:my_app/widgets/bottomnavbar.dart';

class Challenge extends StatefulWidget{
  Challenge({Key? key}) : super(key: key);

  static const route = '/challenge/';
  static const routeDisplayName = 'Challenges';
  
  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {

  
  @override
  Widget build(BuildContext context){
    print('${Challenge.routeDisplayName} built');
  
    return Scaffold(
      appBar: AppBar(
        title: Text(Challenge.routeDisplayName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0
                ),
              ],
            )
          )
        )
      )
    );
  }
}