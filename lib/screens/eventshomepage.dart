import 'package:flutter/material.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:my_app/screens/events/humanrights/humanrights.dart';
import 'package:my_app/screens/events/peace/peace.dart';
import 'package:my_app/screens/events/education/education.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  static const route = '/profilepage/';
  static const routename = 'ProfilePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 173, 248, 175),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 173, 248, 175),
        //iconTheme: const IconThemeData(color: Color(0xFF89453C)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
          },
        ),
        //centerTitle: true,
        title: const Text('Events Categories',
            style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        children: [
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            textColor: Colors.white,
            splashColor: Colors.greenAccent,
            elevation: 8.0,
            child: Container(
              height: 240,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/human_rights.jpg'),
                    fit: BoxFit.cover),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    " Human Rights section ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HumanRights()));
            },
          ),
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            textColor: Colors.white,
            splashColor: Colors.greenAccent,
            elevation: 8.0,
            child: Container(
              height: 240,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/education.jpg'),
                    fit: BoxFit.cover),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    " Education section ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Education()));
            },
          ),
          MaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            textColor: Colors.white,
            splashColor: Colors.greenAccent,
            elevation: 8.0,
            child: Container(
              height: 250,
              //width: 1200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/peace_flag.png'),
                    fit: BoxFit.cover),
              ),
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    " Peace culture section ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      backgroundColor: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Peace()));
            },
          ),
        ],
      ),
    );
  } //build
} //Page