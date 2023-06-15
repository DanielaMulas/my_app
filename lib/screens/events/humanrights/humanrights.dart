import 'package:flutter/material.dart';
import 'package:my_app/screens/events/humanrights/womanrights.dart';

class HumanRights extends StatefulWidget {
  HumanRights({Key? key}) : super(key: key);

  static const route = '/humanrights/';
  static const routename = 'HumanRights';

  @override
  State<HumanRights> createState() => _HumanRights();
}

class _HumanRights extends State<HumanRights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Human Rights', style: TextStyle(color: Colors.black)),
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
              padding: const EdgeInsets.all(8),
              onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => WomanRights()));
              },
              splashColor: Colors.greenAccent,
              child: Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/woman_rights.jpg'),
                  fit: BoxFit.scaleDown)
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Woman Rights Events",
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
            ),
            //Copia e incolla il material button di sopra
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[200],
              child: const Text('Heed not the rabble'),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.teal[300],
              child: const Text('Sound of screams but the'),
            ),
          ],
        ));
  }
}
