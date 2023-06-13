import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/models/userprofile.dart';
import 'package:my_app/screens/loginpage.dart';
import 'package:my_app/screens/profilepage.dart';
import 'package:my_app/screens/eventshomepage.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:my_app/screens/authorizationpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routeDisplayName = 'Homepage';
  
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

int _currentIndex = 0;
final screens = [
  HomePage(),
  Events(),
  //Center(child: Text('Events', style: TextStyle(fontSize:60)),),
  Center(child: Text('Stats', style: TextStyle(fontSize:60)),),
  Profile(),
];
  
  @override
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
              leading: const Icon(Icons.menu),
            ),
            ListTile(
              title: const Text('Authorization'),
              trailing: const Icon(Icons.lock_outline),
              onTap:() => Navigator.push(context,MaterialPageRoute(builder: (context) => Authorization())),
            ),
            ListTile(
              title: const Text('About Us'),
              trailing: const Icon(Icons.question_mark_outlined),
              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AboutPage())),
            ),
            ListTile(
              title: const Text('Log Out'),
              trailing: const Icon(Icons.logout_outlined),
              onTap:() => _logOut(context),
            ),],
        ),
      ),
    );
  }
}

void _logOut(BuildContext context) async{
  final sp = await SharedPreferences.getInstance();
  sp.remove('username');
  sp.remove('password');
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
}