import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:my_app/screens/aboutpage.dart';
import 'package:my_app/models/userprofile.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState(){
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async{
    final pref = await SharedPreferences.getInstance();
    if(pref.getString('username')!= null){
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavBar()));
    };
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';
  //final _formKey = GlobalKey<FormState>();

  final UserProfile _user = UserProfile();

  Future<void> _login() async {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    if (enteredUsername == _user.username && enteredPassword == _user.password) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar()));
      final pref = await SharedPreferences.getInstance();
      pref.setString('username',enteredUsername);
      pref.setString('password',enteredPassword);
      
      _errorMessage = '';
    } else {
      _errorMessage = 'Invalid username or password';
    }

    setState(() {});
  }

  @override
  void dispose() {

    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            //key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _usernameController,
                  /*validator: (val) {
                    if(val==null || val.isEmpty) {
                      return 'Insert username';
                    }
                    else if (val != _user.username) 
                    {
                      return 'Wrong username';
                    }
                    return null;
                  },*/
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  /*validator: (val) {
                    if(val==null || val.isEmpty) {
                      return 'Insert password';
                    }
                    else if (val != _user.username) 
                    {
                      return 'Wrong password';
                    }
                    return null;
                  },*/
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _login,
                  
                  child: Text('Login'),
                ),
                SizedBox(height: 10.0),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: Text('About us'),
                    onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AboutPage())),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


