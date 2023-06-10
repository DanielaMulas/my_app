import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // singleton design pattern
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  late SharedPreferences _pref;

  Future<bool> resetSettings() async {
    return _pref.clear();
  }

  //helper method to manage default values of preferences without the need to call the specific getType method of SharedPreferences
  dynamic _getFromDisk(String key, {dynamic defaultVal}) {
    var value = _pref.get(key);
    if (value == null) {
      _saveToDisk(key, defaultVal);
      return defaultVal;
    } else if (value is List) {
      var val = _pref.getStringList(key);
      return val;
    }
    return value;
  }
  // helper method to call the correct setType method of SharedPreferences
  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _pref.setString(key, content);
    }
    if (content is bool) {
      _pref.setBool(key, content);
    }
    if (content is int) {
      _pref.setInt(key, content);
    }
    if (content is double) {
      _pref.setDouble(key, content);
    }
    if (content is List<String>) {
      _pref.setStringList(key, content);
    }
    if (content == null) {
      _pref.remove(key);
    }
  }

  // Here we define all the keys we will need in the Preferences. We will then access the value with the getter as Preferences.key
  // The getter allows us to forget the specific string used as key in the SharedPreferences and get a list of all saved preferences as variables of the class


  String? get name => _getFromDisk('name');
  set name(String? newname) => _saveToDisk("name", newname);

  String? get email => _getFromDisk('email');
  set email(String? newemail) => _saveToDisk("email", newemail);

  String? get age => _getFromDisk('age');
  set age(String? newage) => _saveToDisk("age", newage);

  String? get country => _getFromDisk('country');
  set country(String? newcountry) => _saveToDisk("country", newcountry);

  String? get city => _getFromDisk('city');
  set city(String? newcity) => _saveToDisk("city", newcity);

  String? get phone => _getFromDisk('phone number');
  set phone(String? newphone) => _saveToDisk("phone number", newphone);



}