import 'package:flutter/material.dart';
import 'package:my_app/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:my_app/repository/stepsDBrepository.dart';
import 'package:my_app/database/stepsDB.dart';

Future<void> main() async {
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine. 
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized(); //special method of flutter that assure that everything is synchronous and correct

  //This opens the database.
  final StepsDatabase database =
      await $FloorStepsDatabase.databaseBuilder('steps_database.db').build(); //this line open the database
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final databaseRepository = DatabaseRepository(database: database);

  //We need to put a database inside a provider
  // A provider just dedicated to the database
  // So when we call the provider, the method will call th dao

  //Multiprovider: list of ptovider you need for the app

  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository. 
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<DatabaseRepository>(
    create: (context) => databaseRepository,
    child: MyApp(),
  ));
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step4Rights',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Splash(),
    );
  }
}


