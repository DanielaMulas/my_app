import 'package:flutter/material.dart';
import 'package:my_app/widgets/bottomnavbar.dart';



class Events extends StatefulWidget {
  Events({Key? key}) : super(key: key);

  static const route = '/profilepage/';
  static const routename = 'ProfilePage';

  @override
  State<Events> createState() => _Events();
}

class _Events extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 173, 248, 175),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 173, 248, 175),
        //iconTheme: const IconThemeData(color: Color(0xFF89453C)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
        ),
        //centerTitle: true,
        title: const Text('Events Categories',
            style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
          //scrollDirection: Axis.vertical,
          //child: Column(
            children: [

              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                //padding: EdgeInsets.all(8.0),              
                textColor: Colors.white,
                splashColor: Colors.greenAccent,
                elevation: 8.0,
                child: Container(
                  height:240,
                  width: 800,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/human_rights.jpg'), 
                        fit: BoxFit.cover
                        
                        ),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Human Rights section",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // ),
                onPressed: () {
                  print('Tapped');
                },
              ),

              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                
                textColor: Colors.white,
                splashColor: Colors.greenAccent,
                elevation: 8.0,
                child: Container(
                  height:240,
                  width: 800,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/School.jpeg'), 
                        fit: BoxFit.cover
                        
                        ),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Education section",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        //backgroundColor: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // ),
                onPressed: () {
                  print('Tapped');
                },
              ),

              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,                
                textColor: Colors.white,
                splashColor: Colors.greenAccent,
                elevation: 8.0,
                child: Container(
                  height:240,
                  width: 1200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/peace_flag.png'), 
                        fit: BoxFit.cover
                        
                        ),
                  ),
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Peace culture section",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // ),
                onPressed: () {
                  print('Tapped');
                },
              ),

            ],
      ),
    );
  } //build
} //Page