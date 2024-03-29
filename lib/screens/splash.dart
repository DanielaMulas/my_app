import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/screens/loginpage.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const LoginPage()))));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 74, 195, 80),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300),
            const Text('Step4Rights',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: Offset(10, 0))
                    ])),
            const SizedBox(height: 20),
            Icon(
              MdiIcons.footPrint,
              color: Colors.white,
              size: 100,
              shadows: const <Shadow>[
                Shadow(
                    color: Colors.black,
                    blurRadius: 20.0,
                    offset: Offset(10, 0))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
