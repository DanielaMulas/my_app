import 'package:flutter/material.dart';
import 'package:my_app/screens/events/peace/runforrefugees.dart';
import 'package:my_app/screens/events/peace/ukrainepeace.dart';


class Peace extends StatelessWidget {
  Peace({Key? key}) : super(key: key);

  static const route = '/humanrights/';
  static const routename = 'HumanRights';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Peace', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 173, 248, 175),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: 10,
          crossAxisCount: 1,
          children: [
            MaterialButton(
              //padding: const EdgeInsets.all(8),
              onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => UkrPeace()));
              },
              color: Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/ukraine_flag.png'),
                  //fit: BoxFit.scaleDown
                  )
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Events to support Ukraine",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),              
              ),
            ),

            MaterialButton(
              
              //padding: const EdgeInsets.all(8),
              onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => Run4Refugee()));
              },
              color: Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(''),
                  //fit: BoxFit.scaleDown
                  )
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Events to support refugees",// Disabled Education Events
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),              
              ),
            ),
            
                       
          ],
        ));
  }
}
