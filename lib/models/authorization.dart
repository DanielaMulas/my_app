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
//import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Authorization {
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

  Future<List<Steps>?> requestDataPeriod(
      BuildContext context, DateTime startDay, DateTime endDay) async {
    //Initialize the result
    List<Steps>? result;

    final codeAuth = await authorize();

    if (codeAuth == 200) {
      //Get the stored access token (Note that this code does not work if the tokens are null)
      final sp = await SharedPreferences.getInstance();
      var access = sp.getString('access');

      //If access token is expired, refresh it
      if (JwtDecoder.isExpired(access!)) {
        await refreshTokens();
        access = sp.getString('access');
      } //if

      //Create the (representative) request

      final start = DateFormat('yyyy-MM-dd').format(startDay);
      final end = DateFormat('yyyy-MM-dd').format(endDay);
      final url = Impact.baseUrl +
          '/' +
          Impact.stepsEndpoint +
          Impact.patientUsername +
          '/daterange/start_date/$start/end_date/$end';
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

      //Get the response
      print('Calling: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      int code = response.statusCode;
      String body = response.body;
      print('CodicePeriodSteps: $code\n');
      print('\nResponseBodyAuth: $body\n');
      //if OK parse the response, otherwise return null
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        result = [];
        /*for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(Steps.fromJson(decodedResponse['data']['date'], decodedResponse['data']['data'][i]));
      }//for*/
        for (var i = 0; i < decodedResponse['data'].length; i++) {
          final date = decodedResponse['data'][i]['date'];
          final data = decodedResponse['data'][i]['data'];
          for (var j = 0; j < data.length; j++) {
            result.add(Steps.fromJson(date, data[j]));
          }
        }
      } //if
      else {
        result = null;
      } //else
      return result;
    
    } //if authorize

    //Return the result
    return null;
  } //requestDataPeriod

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
    } //if authorize
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text('App NOT authorized with code $codeAuth')));
    return null;
  } //requestDataSingleDay
} //AuthorizationPage
