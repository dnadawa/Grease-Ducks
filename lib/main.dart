import 'package:flutter/material.dart';
import 'package:grease_ducks/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');
  var name = prefs.getString('uname');


  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xff009966)
    ),
    home: uid!=null?HomePage(uname: name,):LogIn(),
  ));
}


