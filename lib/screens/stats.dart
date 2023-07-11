import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/repository/stepsDBrepository.dart';
import 'package:my_app/widgets/bottomnavbar.dart';

class Stat extends StatelessWidget {
  Stat({Key? key}) : super(key: key);

  static const route = '/stats/';
  static const routename = 'Statistics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Stat.routename,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(child: Consumer<DatabaseRepository>(
          builder: (context, db, child) {
            return ListView(children: [
              const Align(
                
                child: Text(
                  'INSIGHTS',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color:Color.fromARGB(255, 32, 90, 34),
                    //color: Color.fromARGB(255, 49, 212, 34),
                  ),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 32, 90, 34),
                height: 5,
                thickness: 3,
                //endIndent: 70,
                //indent: 70,
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: db.findStepsMean(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final mean = (snapshot.data)?.round();
                    print('snapshot data of findStepsMean: $mean');
                    return Column(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Steps Mean', //shows me the day of which the steps are shown
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 47, 149, 37),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 47, 149, 37),
                        height: 5,
                        thickness: 3,
                        endIndent: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Average number of steps taken in the last 7 days: \t$mean',
                          style: const TextStyle(
                              fontSize: 20.0,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.left),
                    ]);
                  } else {
                    //A CircularProgressIndicator is shown while the mean is loading
                    return CircularProgressIndicator();
                  } //else
                },
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: db.findStepsMax(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final max = (snapshot.data);
                    print('snapshot data of findStepsMax: $max');
                    return Column(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Steps Max', //shows me the day of which the steps are shown
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 47, 149, 37),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 47, 149, 37),
                        height: 5,
                        thickness: 3,
                        endIndent: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Maximum number of steps taken in the last 7 days: \t$max',
                          style: const TextStyle(
                              fontSize: 20.0,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ]);
                  } else {
                    //A CircularProgressIndicator is shown while the mean is loading
                    return CircularProgressIndicator();
                  } //else
                },
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: db.findStepsMin(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final min = (snapshot.data);
                    print('snapshot data of findStepsMin: $min');
                    return Column(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Steps Min', //shows me the day of which the steps are shown
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 47, 149, 37),
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color.fromARGB(255, 47, 149, 37),
                        height: 5,
                        thickness: 3,
                        endIndent: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Minimum number of steps taken in the last 7 days: \t$min',
                          style: const TextStyle(
                              fontSize: 20.0,
                              //fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ]);
                  } else {
                    //A CircularProgressIndicator is shown while the mean is loading
                    return CircularProgressIndicator();
                  } //else
                },
              ),
            ]);
          },
        )),
      ),
    );
  }
}
