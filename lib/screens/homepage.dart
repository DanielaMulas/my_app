import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/models/userprofile.dart';
import 'package:my_app/screens/loginpage.dart';
import 'package:my_app/screens/profilepage.dart';
import 'package:my_app/screens/eventshomepage.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:my_app/screens/challengespage.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super(key: key);

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
  Widget build(BuildContext context){
    print('${HomePage.routeDisplayName} built');
  
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routeDisplayName),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
              Text('Welcome back *Username*!',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
            ],),]
        ),
              // Cose da aggiungere
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            ListTile(
              title: const Text('Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              leading: const Icon(Icons.menu),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavBar())),
            ),
            const Divider(height: 0, color: Color.fromARGB(255, 186, 172, 172)),
            ListTile(
              title: const Text('Log Out'),
              leading: const Icon(Icons.logout_outlined),
              onTap:() => _logOut(context),
            ),
            const Divider(height: 0, color: Color.fromARGB(255, 186, 172, 172),),
            ListTile(
              title: const Text('About us'),
              leading: const Icon(
                 MdiIcons.informationOutline,
                 ),
              onTap:() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AboutPage())),
            ),
            const Divider(height: 0, color: Color.fromARGB(255, 186, 172, 172),),
          ],
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