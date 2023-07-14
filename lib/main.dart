import 'package:my_app/database/stepsDB.dart';
import 'package:my_app/repository/stepsDBrepository.dart';
import 'package:my_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/events/humanrights/runningevent.dart';
import 'package:my_app/screens/stats.dart';



Future<void> main() async {
  

  WidgetsFlutterBinding.ensureInitialized();

  
  final StepsDatabase database =
      await $FloorStepsDatabase.databaseBuilder('app_database.db').build();
  
  final databaseRepository = DatabaseRepository(database: database);

  final chosenDay = DateTime(2023, 7, 17);

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository.
  //That instance will be then shared through the platform and will be unique.
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<DatabaseRepository>(
        create: (context) => databaseRepository,
      ),
      ChangeNotifierProvider<TimerData>(
        create: (context) => TimerData(context, chosenDay),
      ),
      ChangeNotifierProvider<PointsData>(
        create: (context) => PointsData(),
      ),
    ],
    child: const MyApp(),
  ));
} //main

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steps4Rights',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Splash(),
    );
  }
}
