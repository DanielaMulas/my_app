import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/screens/homepage.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({Key? key}) : super(key:key);

  static const routeDisplayName = 'LoginPage';


  @override
  Widget build(BuildContext context){
    print('$LoginPage.routeDisplayName');
    
    return Scaffold(
      appBar: AppBar(
        title: Text(LoginPage.routeDisplayName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('To the HomePage'),
              onPressed: () => _toHomePage(context),
            ),
            ElevatedButton(
              child: Text('To the AboutPage'),
              onPressed: () => _toAboutPage(context),
            ),
          ],
        ),
      ), 

    );
  }


  void _toHomePage(BuildContext context){
    //Pop
    Navigator.pop(context);
    //Push HomePage
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void _toAboutPage(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
  }

}