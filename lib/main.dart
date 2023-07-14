import 'package:my_app/database/stepsDB.dart';
import 'package:my_app/repository/stepsDBrepository.dart';
import 'package:my_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/events/humanrights/runningevent.dart';
import 'package:my_app/screens/stats.dart';

// We modified the main

Future<void> main() async {
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine.
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.

  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final StepsDatabase database =
      await $FloorStepsDatabase.databaseBuilder('app_database.db').build();
  //This creates a new DatabaseRepository from the StepDatabase instance just initialized
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
