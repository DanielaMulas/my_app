import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/database/entities/stepsEntity.dart';
import 'package:my_app/repository/stepsDBrepository.dart';
import 'package:my_app/screens/loginpage.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:my_app/models/authorization.dart';
import 'package:my_app/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routeDisplayName = 'Homepage';

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _retrieveName();
  }

  void _retrieveName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? 'enjoy';
    //If name already exists the app will display "Welcome, *name*!" otherwise it will display "Welcome, enjoy!"
    setState(() {});
  }

  int? totalSteps;
  String? name;
  final int maxSteps =
      30000; //Assumption: the user take less than 30000 steps a day

  final Authorization auth = Authorization();

  DateTime day = DateTime.now()
      .subtract(const Duration(days: 1)); //initalized as "yesterday"
  String formattedDayDisplay = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().subtract(const Duration(days: 1)));

  DateTime startDayWeekAgo = DateTime.now().subtract(const Duration(days: 7));

  Future<List<int>> calculateSums() async {
    final weekSteps = List<int>.filled(7, 0); //List of 7 int initialized to 0

    final dbRepository =
        Provider.of<DatabaseRepository>(context, listen: false);

    final now = DateTime.now();
    final List<DateTime> weekDays = [
      now.subtract(const Duration(days: 7)),
      now.subtract(const Duration(days: 6)),
      now.subtract(const Duration(days: 5)),
      now.subtract(const Duration(days: 4)),
      now.subtract(const Duration(days: 3)),
      now.subtract(const Duration(days: 2)),
      now.subtract(const Duration(days: 1)),
    ];

    for (int i = 0; i < 7; i++) {
      if (mounted) {
        //When a widget is mounted, it means that it has been inserted into the widget tree and is being displayed on the screen.
        final dayResult = await auth.requestDataSingleDay(context, weekDays[i]);
        if (dayResult != null) {
          for (final step in dayResult) {
            weekSteps[i] += step.value;
          } //at the end weekSteps[i] contains the number of steps taken in the day i

          // Insert the steps into the database
          final stepsEntity =
              StepsEntity(value: weekSteps[i], day: weekDays[i].toString());

          //Print
          final daySteps = weekSteps[i];
          final dayEntity = weekDays[i].toString();
          print('value inserted in StepsEntity: $daySteps');
          print('day inserted in StepsEntity: $dayEntity');
          print('Step to add to the database: $i, $stepsEntity');
          await dbRepository.insertStep(stepsEntity);
        }
      }
    }

    return weekSteps;
  }

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routeDisplayName} built');

    return Scaffold(
      appBar: AppBar(
        title: const Text(HomePage.routeDisplayName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text('Welcome, $name!',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      fontStyle: FontStyle.italic)),
              const SizedBox(height: 20),
              FutureBuilder<List<Steps>?>(
                future: auth.requestDataSingleDay(context, day),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var result = snapshot.data;
                    print('\nSteps List (futureBuilder1): $result');
                    final totalSteps =
                        result?.fold<int>(0, (sum, step) => sum + step.value) ??
                            0;
                    //If the result isn't null, totalSteps corresond to the sum of the values returned by the function requestDataSingleDay
                    print('\nTOTAL STEPS: $totalSteps\n');
                    return SizedBox(
                      width: 800,
                      height: 300,
                      child: Column(
                        children: [
                          Text(
                            'Steps of the day ($formattedDayDisplay):', //shows me the day of which the steps are shown
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 32, 90, 34),
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 32, 90, 34),
                            height: 5,
                            thickness: 3,
                            //endIndent: 220,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Icon(
                                    MdiIcons.arrowLeftDropCircle,
                                    size: 30,
                                    color:
                                        const Color.fromARGB(255, 32, 90, 34),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      day = day.subtract(const Duration(
                                          days:
                                              1)); //update the day whose steps are requested (the previous one)
                                      formattedDayDisplay =
                                          DateFormat('dd-MM-yyyy').format(
                                              day); //update of the text that shows me the day to which the steps displayed correspond
                                    });
                                  }),
                              CircularPercentIndicator(
                                radius: 85,
                                lineWidth: 30,
                                percent: totalSteps / maxSteps <= 1
                                    ? totalSteps / maxSteps
                                    : 1,
                                center: Text(
                                  totalSteps.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                progressColor: Colors.green,
                                backgroundColor:
                                    const Color.fromARGB(255, 106, 238, 113),
                              ),
                              IconButton(
                                  icon: Icon(
                                    MdiIcons.arrowRightDropCircle,
                                    size: 30,
                                    color:
                                        const Color.fromARGB(255, 32, 90, 34),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      day = day.add(const Duration(
                                          days:
                                              1)); //update the day whose steps are requested (the following one)
                                      formattedDayDisplay =
                                          DateFormat('dd-MM-yyyy').format(
                                              day); //update of the text that shows me the day to which the steps displayed correspond
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('There is an error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Steps trend of this week:', //shows me the day of which the steps are shown
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
              const SizedBox(height: 30),
              FutureBuilder<List<int>>(
                future: calculateSums(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var weekSteps = snapshot.data!;
                    print('\nSteps week (futureBuilder2): $weekSteps');

                    return Column(
                      children: [
                        SizedBox(
                          height: 200.0,
                          child: LineChart(
                            LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: weekSteps
                                        .asMap()
                                        .entries
                                        .map((entry) => FlSpot(
                                            entry.key.toDouble(),
                                            entry.value.toDouble()))
                                        .toList(),
                                    isCurved: false,
                                    colors: [
                                      Colors.cyan,
                                      Colors.green,
                                      Colors.amberAccent,
                                      Colors.redAccent,
                                      Colors.purpleAccent
                                    ],
                                    barWidth: 5,
                                    dotData: FlDotData(show: true),
                                    belowBarData: BarAreaData(
                                      show: false,
                                    ),
                                  ),
                                ],
                                minX: 0,
                                maxX: weekSteps.length - 1,
                                minY: 0,
                                maxY: maxSteps.toDouble(),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    getTitles: (value) {
                                      if (value % 1 == 0) {
                                        DateTime dateTime = startDayWeekAgo
                                            .add(Duration(days: value.toInt()));
                                        String formattedDate =
                                            DateFormat('dd/MM')
                                                .format(dateTime);
                                        return formattedDate;
                                      }
                                      return '';
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),

                                  rightTitles: SideTitles(
                                      showTitles:
                                          false), // Remove titles on the right side
                                  topTitles: SideTitles(showTitles: false),
                                ),
                                gridData: FlGridData(show: false),
                                lineTouchData: LineTouchData(
                                    touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor:
                                      const Color.fromARGB(255, 106, 214, 208),
                                  tooltipPadding: EdgeInsets.all(8),
                                  tooltipRoundedRadius: 8,
                                  getTooltipItems:
                                      (List<LineBarSpot> lineBarsSpot) {
                                    return lineBarsSpot.map((lineBarSpot) {
                                      final int spotIndex =
                                          lineBarSpot.spotIndex;
                                      final double spotValueY = lineBarSpot.y;
                                      final String spotValueText =
                                          '${spotValueY.toInt()}';

                                      return LineTooltipItem(
                                        spotValueText,
                                        const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      );
                                    }).toList();
                                  },
                                ))),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('There is an error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            ListTile(
              title: const Text(
                'Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              leading: const Icon(Icons.menu),
              onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
              ),
            ),
            const Divider(height: 0, color: Color.fromARGB(255, 186, 172, 172)),
            ListTile(
              title: const Text('About Us'),
              trailing: Icon(MdiIcons.informationVariantCircleOutline),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              ),
            ),
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 186, 172, 172),
            ),
            ListTile(
              title: const Text('Log Out'),
              trailing: const Icon(Icons.logout_outlined),
              onTap: () => _logOut(context),
            ),
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 186, 172, 172),
            ),
          ],
        ),
      ),
    );
  }

  void _logOut(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');
    sp.remove('password');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
} //homestate
