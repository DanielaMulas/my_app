import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/screens/loginpage.dart';
import 'package:my_app/screens/profilepage.dart';
import 'package:my_app/screens/eventshomepage.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:my_app/screens/authorizationpage.dart';
import 'package:http/http.dart' as http;
//import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'dart:io';
//import 'dart:js';
import 'package:my_app/models/steps.dart';
import 'package:my_app/utils/impact.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:my_app/models/steps.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home/';
  static const routeDisplayName = 'Homepage';

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _currentIndex = 0;
  final screens = [
    const HomePage(),
    Events(),
    //Center(child: Text('Events', style: TextStyle(fontSize:60)),),
    const Center(
      child: Text('Stats', style: TextStyle(fontSize: 60)),
    ),
    Profile(),
  ];

  /*@override
  void initState() {
    super.initState();
    requestData(); // Fetch steps data when the widget is initialized
  }

  Future<void> requestData() async {
    final result = await Authorization._requestData();
    if (result != null) {
      Provider.of<StepProvider>(context, listen: false).updateSteps(result);
    }
  }*/

  int? totalSteps;


  

  

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routeDisplayName} built');

    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routeDisplayName),
        
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Welcome back *Username*!',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              ],
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.transparent,
                )
              ),
              onPressed: () async {
                final result = await _requestData();
                print('STEP RESULT: $result');
                final message =
                  result == null ? 'Request failed' : 'Request successful';
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
                if (result!=null){
                  totalSteps = result.fold<int>(0, (sum, step) => sum + step.value);
                  print('\nTOTAL STEPS: $totalSteps\n');
                }
              }, 
          //child: const Icon(Icons.refresh)
        
              child: SizedBox(
                /*child: Consumer<StepProvider>(
                  builder: (context, stepProvider, child) {
                    //final stepsData = stepProvider.stepsData;
                    final totalSteps = stepProvider.stepsData.length;
                        //stepsData.fold<int>(0, (sum, step) => sum + step.value);
              
                    return SizedBox(*/
                    
                      width: 200,
                      height: 200,
                      child: CircularPercentIndicator(
                        radius: 150,
                        lineWidth: 20,
                        percent: totalSteps == null ? 0 : totalSteps!/25000,
                        
                        center: Text(
                          '$totalSteps', 
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color:Colors.black,
                          )
                        ),
                        
                        progressColor: Colors.cyan,
                        backgroundColor: Colors.blueGrey,
                      ),
                    ),
            ),
                
              
            
          ]),
          // Cose da aggiungere
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 50),
              ListTile(
                title: const Text('Menu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                leading: const Icon(Icons.menu),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BottomNavBar())),
              ),
              const Divider(height: 0, color: Color.fromARGB(255, 186, 172, 172)),
              ListTile(
                title: const Text('Authorization'),
                trailing: const Icon(Icons.lock_outline),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Authorization())),
              ),
              const Divider(
                height: 0,
                color: Color.fromARGB(255, 186, 172, 172),
              ),
              ListTile(
                title: const Text('About Us'),
                trailing: Icon(MdiIcons.informationVariantCircleOutline),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutPage())),
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
  }

  void _logOut(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('username');
    sp.remove('password');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));

  }

  Future<List<Steps>?> _requestData() async {
  //Initialize the result
  List<Steps>? result;

  //Get the stored access token (Note that this code does not work if the tokens are null)
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');

  //If access token is expired, refresh it
  /*if(JwtDecoder.isExpired(access!)){
    await _refreshTokens();
    access = sp.getString('access');
  }//if
  */

  //request of the data (steps)
  final day = '2023-06-21';
  final url = Impact.baseUrl + '/' + Impact.stepsEndpoint +  '/' + Impact.patientUsername + '/day/$day/';
  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  //Get the response
  print('Calling: $url');
  final response = await http.get(Uri.parse(url), headers: headers);
  
  //if OK parse the response, otherwise return null
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    result = [];
    for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
      result.add(Steps.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
    }//for
    //await sp.setStringList('StepsList', result.map((steps) => jsonEncode(steps)).toList());
    //Provider.of<StepProvider>(context, listen: false).updateSteps(result);
  } //if
  else{
    result = null;
  }//else

  
  //Return the result
  return result;

  } //_requestData
