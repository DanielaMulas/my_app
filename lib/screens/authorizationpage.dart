import 'dart:convert';
import 'dart:io';
import 'dart:core';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:my_app/models/steps.dart';
import 'package:my_app/utils/impact.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:my_app/models/steps.dart';
//import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class Authorization extends StatelessWidget {
  const Authorization({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Authorization")         
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                    'App authorization',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                    textAlign: TextAlign.left,
                  ),
                  const Divider(height: 10, thickness:5, color: Color.fromARGB(255, 59, 126, 62), endIndent: 100,),
              ListTile(
                title: Text('Click here to authorize'),
                leading: Icon(MdiIcons.cursorDefaultClick),
                onTap: () async {
                  final result = await authorize();
                  final message =
                      result == 200 ? 'Request successful' : 'Request failed with code $result';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                //child: Text('Authorize the app')
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                    'App unauthorization',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                    textAlign: TextAlign.center,
                  ),
              const Divider(height: 10, thickness:5, color: Color.fromARGB(255, 59, 126, 62), endIndent: 100,),              
              ListTile(
                title: Text('Click here to unauthorize'),
                leading: Icon(MdiIcons.cursorDefaultClick),
                onTap: () async {
                  final sp = await SharedPreferences.getInstance();
                  await sp.remove('access');
                  await sp.remove('refresh');
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text('Tokens have been deleted')));
                },
                //child: Text('Unauthorize the app')
              ),
              SizedBox(
                height: 10,
              ),
              /*const Text(
                'Get the steps',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                textAlign: TextAlign.left,
              ),
              const Divider(height: 10, thickness:5, color: Color.fromARGB(255, 59, 126, 62), endIndent: 100,),
              
              ListTile(
                title: Text('Click here to get the steps'),
                leading: Icon(MdiIcons.cursorDefaultClick),
                onTap: () async {
                  final result = await requestDataSingleDay(context,day);
                  print(result);
                  final message =
                      result == null ? 'Request failed' : 'Request successful';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                //child: Text('Get the data')
              ),*/
              SizedBox(height: 10),
              const Text(
                    'Today steps',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                    textAlign: TextAlign.center,
                  ),
              const Divider(height: 10, thickness:5, color: Color.fromARGB(255, 59, 126, 62), endIndent: 100,),              
              ListTile(
                title: Text('Click here to obtain the steps done today'),
                leading: Icon(MdiIcons.cursorDefaultClick),
                onTap: () async {
                  final result = await _requestDataPeriod();
                  print(result);
                  final message =
                      result == null ? 'Request failed' : 'Request successful';
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                },
                
              ),
          ],
        ),
      ),
    );
  } //build

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int?> authorize() async {

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
  } //_authorize

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  /*Future<List<Steps>?> _requestData() async {
    //Initialize the result
    List<Steps>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final day = '2023-06-27';
    final url = Impact.baseUrl + '/' + Impact.stepsEndpoint + Impact.patientUsername + '/day/$day/';
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

  } *///_requestData

  //This method allows to obtain the JWT token pair from IMPACT and store it in SharedPreferences
  Future<int> refreshTokens() async {

    //Create the request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
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

  } //refreshTokens

  Future<List<Steps>?> _requestDataPeriod() async {
    //Initialize the result
    List<Steps>? result;

    //Get the stored access token (Note that this code does not work if the tokens are null)
    final sp = await SharedPreferences.getInstance();
    var access = sp.getString('access');

    //If access token is expired, refresh it
    if(JwtDecoder.isExpired(access!)){
      await refreshTokens();
      access = sp.getString('access');
    }//if

    //Create the (representative) request
    final now= DateTime.now().subtract(const Duration(days: 1));
    final startDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final start = DateFormat('yyyy-MM-dd').format(startDay);
    final endDay=DateTime.now();
    final end = DateFormat('yyyy-MM-dd').format(endDay);
    final url = Impact.baseUrl + '/' + Impact.stepsEndpoint + Impact.patientUsername + '/daterange/start_date/$start/end_date/$end';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    print('Calling: $url');
    final response = await http.get(Uri.parse(url), headers: headers);
    int code=response.statusCode;
    String body = response.body;
    print('CodicePageAuth: $code\n');
    print('\nResponseBodyAuth: $body\n');
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

  Future<List<Steps>?> requestDataSingleDay(
      BuildContext context, DateTime dayChosen) async {
    // Initialize the result
    List<Steps>? result;

    final codeAuth = await authorize();

    if (codeAuth == 200) {
      // Get the stored access token (Note that this code does not work if the tokens are null)
      final sp = await SharedPreferences.getInstance();
      var access = sp.getString('access');

      //If access token is expired, refresh it
      if (JwtDecoder.isExpired(access!)) {
        await refreshTokens();
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
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text('App NOT authorized with code $codeAuth')));
    return null;
  }


} //AuthorizationPage
              

 