import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:my_app/screens/homepage.dart';


class AboutUsPage extends StatelessWidget{
  const AboutUsPage({Key? key}) : super(key:key);

  static const routeDisplayName = 'AboutUsPage';

  @override
  Widget build(BuildContext context){
    print('$AboutUsPage.routeDisplayName');
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AboutUsPage.routeDisplayName),
      ),
      body: Center(
        child: Column(
            children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('About Us:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              ],),
              const Text("Hi, thank you for joining us!\n We are three students from Padova's University and we care about blablabla", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),),
            ],),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //Changing color to icons when selected 
        selectedItemColor: Colors.black,             
        selectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        //unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        backgroundColor: Colors.pink,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: "Home",   
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available, color: Colors.white),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.white),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
     
    );
  }
  //void _toHomePage(BuildContext context){
    //Pop
  //  Navigator.pop(context);
    //Push HomePage
  //  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  //}
}