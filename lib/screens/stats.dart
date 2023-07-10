import 'package:flutter/material.dart';
import 'package:my_app/screens/events/peace/runforrefugees.dart';
import 'package:my_app/screens/events/peace/ukrainepeace.dart';
import 'package:provider/provider.dart';
import 'package:my_app/repository/stepsDBrepository.dart';

class stat extends StatelessWidget {
  stat({Key? key}) : super(key: key);

  static const route = '/stats/';
  static const routename = 'Stats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<DatabaseRepository>(
        builder: (context, db, child) {
          return FutureBuilder(
            future: db.findStepsMean(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final mean = (snapshot.data)?.round();
                print('snapshot data of findStepsMean: $mean');
                return Column(children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Media di boh passi:', //shows me the day of which the steps are shown
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 32, 90, 34),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 32, 90, 34),
                    height: 5,
                    thickness: 3,
                    endIndent: 70,
                  ),
                  const SizedBox(height: 20),
                  Text('Steps Mean of the last 7 days:\n$mean',
                      style: const TextStyle(
                          fontSize: 18.0,
                          //fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ]);
              } else {
                //A CircularProgressIndicator is shown while the mean is loading
                return CircularProgressIndicator();
              } //else
            },
          );
        },
      )),
    );
  }
}
