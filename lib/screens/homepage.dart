import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/screens/loginpage.dart';
import 'package:my_app/screens/profilepage.dart';
import 'package:my_app/screens/eventshomepage.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:my_app/models/authorization.dart';
import 'package:my_app/models/steps.dart';
//import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:my_app/models/steps.dart';
import 'package:intl/intl.dart';

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
    /*const Center(
      child: Text('Stats', style: TextStyle(fontSize: 60)),
    ),*/
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _retrieveName(); // Fetch the name inserted in the profilePage when the widget is initialized
  }

  void _retrieveName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? 'enjoy';

    setState(() {});
  }
  /*Future<void> requestData() async {
    final result = await Authorization._requestData();
    if (result != null) {
      Provider.of<StepProvider>(context, listen: false).updateSteps(result);
    }
  }*/

  int? totalSteps;
  String? name;
  final int maxSteps = 20000;

  final Authorization auth = Authorization();

  DateTime day = DateTime.now()
      .subtract(const Duration(days: 1)); //initalized as "yesterday"
  String formattedDayDisplay = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().subtract(const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routeDisplayName} built');

    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routeDisplayName),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              //SizedBox(height: 5),
              Text('Welcome, $name!',
                style:
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                      fontStyle: FontStyle.italic)
              ),
              const SizedBox(height: 20),

              
              FutureBuilder<List<Steps>?>(
                future: auth.requestDataSingleDay(context, day),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var result = snapshot.data;
                    print('\nSteps List (result): $result');
                    final totalSteps =
                        result?.fold<int>(0, (sum, step) => sum + step.value) ??
                            0;
                    print('\nTOTAL STEPS: $totalSteps\n');
                    return SizedBox(
                      width: 800,
                      height: 400,
                      child: Column(
                        children: [
                          Text(
                            'Steps of the day ($formattedDayDisplay):',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color:  Color.fromARGB(255, 32, 90, 34),),
                          ),
                          const Divider(
                            color:  Color.fromARGB(255, 32, 90, 34),
                            height: 5,
                            thickness: 3,
                            //endIndent: 220,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //const SizedBox(width: 50),
                              IconButton(
                                  icon: Icon(
                                    MdiIcons.arrowLeftDropCircle,
                                    size: 30,
                                    color: Color.fromARGB(255, 32, 90, 34),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      day = day.subtract(const Duration(days: 1));
                                      formattedDayDisplay =
                                          DateFormat('dd-MM-yyyy').format(day);
                                    });
                                  }),
                              //const SizedBox(width: 140),
                              CircularPercentIndicator(
                                radius: 85,
                                lineWidth: 30,
                                percent: totalSteps / maxSteps,
                                center: Text(
                                  '$totalSteps',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                                progressColor: Colors.green,
                                backgroundColor:
                                    Color.fromARGB(255, 106, 238, 113),
                              ),
                              IconButton(
                                  icon: Icon(
                                    MdiIcons.arrowRightDropCircle,
                                    size: 30,
                                    color: Color.fromARGB(255, 32, 90, 34),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      day = day.add(const Duration(days: 1));
                                      formattedDayDisplay =
                                          DateFormat('dd-MM-yyyy').format(day);
                                    });
                                  }),
                              //const SizedBox(width: 50),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('There is an error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
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
                MaterialPageRoute(builder: (context) => BottomNavBar()),
              ),
            ),
            const Divider(height: 0, color: Color.fromARGB(255, 186, 172, 172)),
            /*ListTile(
              title: const Text('Authorization'),
              trailing: const Icon(Icons.lock_outline),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const Authorization()),
              ),
            ),*/
            const Divider(
              height: 0,
              color: Color.fromARGB(255, 186, 172, 172),
            ),
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

  /*Future<List<Steps>?> _requestData(
      BuildContext context, DateTime dayChosen) async {
    // Initialize the result
    List<Steps>? result;

    final codeAuth =  await _authorize();

    if (codeAuth == 200) {
      // Get the stored access token (Note that this code does not work if the tokens are null)
      final sp = await SharedPreferences.getInstance();
      var access = sp.getString('access');

      //If access token is expired, refresh it
      if (JwtDecoder.isExpired(access!)) {
        await auth.refreshTokens();
        access = sp.getString('access');
      } //if

      String formattedDayLink = DateFormat('yyyy-MM-dd').format(dayChosen);
      //String formattedDayDisplay = DateFormat('dd-MM-yyyy').format(DayChosen);

      final url = Impact.baseUrl +
          '/' +
          Impact.stepsEndpoint +
          Impact.patientUsername +
          '/day/$formattedDayLink/';
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

      // Get the response
      print('Calling: $url');
      final response = await http.get(Uri.parse(url), headers: headers);

      int cod = response.statusCode;
      String body = response.body;
      print('\nGET RESPONSE CODE: $cod\n');
      print('\nRESPONSE BODY: $body\n');

      // If OK, parse the response; otherwise, return null
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        result = [];
        for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
          result.add(Steps.fromJson(decodedResponse['data']['date'],
              decodedResponse['data']['data'][i]));
        }
        /*ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
              SnackBar(content: Text('App authorized and data retrieved')));*/
        // Return the result
      } else {
        result = [Steps(time: DateTime.now(), value: 0)];
      }

      // Return the result

      return result;
    }
    print(codeAuth);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text('App NOT authorized with code $codeAuth')));
    
    return null;
  }



  Future<int> _refreshTokens() async {
    //Create the request
    final url = Impact.baseUrl + '/' + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the respone
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200 set the tokens
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Return just the status code
    return response.statusCode;
  } //_refreshTokens

  Future<int?> _authorize() async {
    //Create the request
    final url = Impact.baseUrl + '/' + Impact.tokenEndpoint;
    print('url: $url');
    final body = {'username': Impact.username, 'password': Impact.password};

    //Get the response
    print('Calling: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200, set the token
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_author
  */

} //homestate
