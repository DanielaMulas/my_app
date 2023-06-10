import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/models/userprofile.dart';
import 'package:my_app/screens/profilepage.dart';
import 'package:my_app/screens/homepage.dart';
import 'package:my_app/screens/challengespage.dart';

class BottomNavBar extends StatefulWidget{
  BottomNavBar({Key? key}) : super(key: key);


  
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

int _currentIndex = 0;
final screens = [
  HomePage(),
  Challenge(),
  Center(child: Text('Stats', style: TextStyle(fontSize:60)),),
  Profile(),
];
  
  @override
  Widget build(BuildContext context){
      
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        //Changing color to icons when selected 
        selectedItemColor: Colors.white,   
        unselectedItemColor: Colors.white70,          
        selectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        //unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  const Icon(Icons.home, color: Colors.white),
            label: "Home",      
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.event_available, color: Colors.white),
            label: 'Challenges',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.white),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}