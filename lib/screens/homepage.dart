import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
         
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             ListTile(
              title: const Text('Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              leading: Icon(Icons.menu),
              
            ),
            ListTile(
              title: const Text('Profile'),
              trailing: Icon(Icons.account_circle_outlined),
              onTap:(){}
            ),
            ListTile(
              title: const Text('Log Out'),
              trailing: Icon(Icons.logout_outlined),
              onTap:(){}
            ),
          ],
        ),
      ),

    );
  }
}