import 'package:flutter/material.dart';
import 'package:my_app/screens/events/humanrights/womanrights.dart';
import 'package:my_app/screens/events/humanrights/pride.dart';

class HumanRights extends StatelessWidget {
  const HumanRights({Key? key}) : super(key: key);

  static const route = '/humanrights/';
  static const routename = 'HumanRights';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              const Text('Human Rights', style: TextStyle(color: Colors.black)),
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
                    MaterialPageRoute(builder: (context) => WomanRights()));
              },
              color: const Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/woman_rights.jpg'),
                        scale: 2.1)),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Women Rights Events",
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Pride()));
              },
              color: const Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/pride_flag.png'),
                )),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Pride Events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
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
