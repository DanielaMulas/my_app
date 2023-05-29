import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/models/userprofile.dart';
import 'package:my_app/screens/profilepage.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);

  static const routeDisplayName = 'Homepage';

  @override
  Widget build(BuildContext context){
    print('${HomePage.routeDisplayName} built');
  
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routeDisplayName),
      ),
      body: Center(
        child: Column(
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text('Welcome back *Username*!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
          ],),]
        ),
              // Cose da aggiungere
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //Changing color to icons when selected 
        selectedItemColor: Colors.black,             
        selectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        //unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 14),
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
              },
            ),
            label: "Home",      
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.event_available, color: Colors.white),
            label: 'Events',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart, color: Colors.white),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
              },
            ),
            label: 'Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              leading: const Icon(Icons.menu),
            ),
            ListTile(
              title: const Text('Profile'),
              trailing: const Icon(Icons.account_circle_outlined),
              onTap:(){}
            ),
            ListTile(
              title: const Text('Contact Us'),
              trailing: const Icon(Icons.question_mark_outlined),
              onTap: (){},
            ),
            ListTile(
              title: const Text('Log Out'),
              trailing: const Icon(Icons.logout_outlined),
              onTap:(){},
            
            ),
          ],
        ),
      ),

    );
  }
}