import 'package:flutter/material.dart';
import 'package:my_app/screens/events/peace/runforrefugees.dart';
import 'package:my_app/screens/events/peace/ukrainepeace.dart';

class Peace extends StatelessWidget {
  const Peace({Key? key}) : super(key: key);

  static const route = '/peace/';
  static const routename = 'Peace';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Peace', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 173, 248, 175),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: 10,
          crossAxisCount: 1,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UkrPeace()));
              },
              color: const Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/ukraine_flag.png'),
                )),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Events to support Ukraine",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Run4Refugee()));
              },
              color: const Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/refugees.jpg'),
                )),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Events to support refugees",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
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
