import 'package:flutter/material.dart';
import 'package:hackerapp/view/dhashboard.dart';
import 'package:hackerapp/view/home.dart';
import 'package:hackerapp/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? email = prefs.getString('email');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: email == '' ? Login() : HomePage(emailid: email),
    home: Login(),
  ));
}
