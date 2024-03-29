import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/repository/stepsDBrepository.dart';
import 'package:my_app/widgets/bottomnavbar.dart';

class PointsData extends ChangeNotifier {
  int points = 600;

  void addPoints(int value) {
    points += value;
    notifyListeners();
  }
}

class Stat extends StatelessWidget {
  const Stat({Key? key}) : super(key: key);

  static const route = '/stats/';
  static const routename = 'Statistics';

  @override
  Widget build(BuildContext context) {
    final pointsData = Provider.of<PointsData>(context);
    final updatedPoints = pointsData.points;
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
                MaterialPageRoute(builder: (context) => const BottomNavBar()));
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
                    color: Color.fromARGB(255, 32, 90, 34),
                  ),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 32, 90, 34),
                height: 5,
                thickness: 3,
              ),
              const SizedBox(height: 30),

              //Steps average
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
                          'Steps Mean',
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
                              fontSize: 20.0, color: Colors.black),
                          textAlign: TextAlign.left),
                    ]);
                  } else {
                    //A CircularProgressIndicator is shown while the mean is loading
                    return const CircularProgressIndicator();
                  } //else
                },
              ),
              const SizedBox(height: 30),

              //Steps maximum
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
                          'Steps Max',
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
                              fontSize: 20.0, color: Colors.black)),
                    ]);
                  } else {
                    return const CircularProgressIndicator();
                  } //else
                },
              ),
              const SizedBox(height: 30),

              //Steps minimum
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
                          'Steps Min',
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
                              fontSize: 20.0, color: Colors.black)),
                    ]);
                  } else {
                    return const CircularProgressIndicator();
                  } //else
                },
              ),
              const SizedBox(height: 30),

              //Points obtained from the events
              const Text(
                'Points', //shows how many points the person has accumulated
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 47, 149, 37),
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
                  'Number of points you have accumulated until now: \t$updatedPoints',
                  style: const TextStyle(fontSize: 20.0, color: Colors.black)),
            ]);
          },
        )),
      ),
    );
  }
}
