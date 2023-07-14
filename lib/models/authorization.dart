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
import 'package:intl/intl.dart';

class Authorization {
  Future<int?> authorize() async {
    //Request
    final url = Impact.baseUrl + '/' + Impact.tokenEndpoint;
    
    final body = {'username': Impact.username, 'password': Impact.password};

    //Get the response
    print('Calling url to authorize: $url');
    final response = await http.post(Uri.parse(url), body: body);

    //If 200 --> all good, get the token
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
    } //if

    //Just return the status code
    return response.statusCode;
  } //_authorize

  Future<int> refreshTokens() async {
    //Request
    final url = Impact.baseUrl + Impact.refreshEndpoint;
    final sp = await SharedPreferences.getInstance();
    final refresh = sp.getString('refresh');
    final body = {'refresh': refresh};

    //Get the respone
    print('Calling url to refresh tokens: $url');
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
    
    List<Steps>? result;

    final codeAuth = await authorize();

    if (codeAuth == 200) {
      //check if the authorization went well
      //Get the stored access token
      final sp = await SharedPreferences.getInstance();
      var access = sp.getString('access');

      //If access token is expired, refresh it
      if (JwtDecoder.isExpired(access!)) {
        await refreshTokens();
        access = sp.getString('access');
      } //if

      //Request for the steps of the defined range
      final start = DateFormat('yyyy-MM-dd').format(startDay);
      final end = DateFormat('yyyy-MM-dd').format(endDay);
      final url = Impact.baseUrl +
          '/' +
          Impact.stepsEndpoint +
          Impact.patientUsername +
          '/daterange/start_date/$start/end_date/$end';
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

      //Get the response
      print('Calling url to get the data of the period specified: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      int code = response.statusCode;
      String body = response.body;
      print('CodicePeriodSteps: $code\n');
      print('\nResponseBodyPeriod: $body\n');
      //if OK parse the response, otherwise return null
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        result = [];

        for (var i = 0; i < decodedResponse['data'].length; i++) {
          final date = decodedResponse['data'][i]['date'];
          final data = decodedResponse['data'][i]['data'];
          for (var j = 0; j < data.length; j++) {
            result.add(Steps.fromJson(date, data[j]));
          } //I keep the date fixed and get the data of that day
        } //for
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
      //if the authorization went well
      // Get the stored access token
      final sp = await SharedPreferences.getInstance();
      var access = sp.getString('access');

      //If access token is expired, refresh it
      if (JwtDecoder.isExpired(access!)) {
        await refreshTokens();
        access = sp.getString('access');
      } //if

      String formattedDayLink = DateFormat('yyyy-MM-dd').format(dayChosen);

      final url = Impact.baseUrl +
          '/' +
          Impact.stepsEndpoint +
          Impact.patientUsername +
          '/day/$formattedDayLink/';
      final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

      // Get the response
      print('Calling url for data of the day: $url');
      final response = await http.get(Uri.parse(url), headers: headers);

      int cod = response.statusCode;
      String body = response.body;
      print('\nGET RESPONSE CODE: $cod\n');
      print('\nRESPONSE BODY SINGLEDAY: $body\n');

      // If OK, parse the response; otherwise, return null
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        result = [];
        final data = decodedResponse['data'];
        
        if (data is Map<String, dynamic>) {
          /*"is" is used to check the type of an object
          The Map<String, dynamic> type represents a map (key-value pairs) where the keys are strings and the values can be of any type (dynamic).        
          This check is uded to safely access the date and data fields later in the code, avoiding potential errors when the data is null.*/
          final date = data['date'];
          final stepsData = data['data'];

          if (stepsData is List) {
            for (final stepData in stepsData) {
              result.add(Steps.fromJson(date, stepData));
            }
          }
        }

        if (result.isEmpty) {
          result = [Steps(time: DateTime.now(), value: 0)];
        }

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
    //display only in case the request was not authorized
    return null;
  } //requestDataSingleDay


} //AuthorizationPage
