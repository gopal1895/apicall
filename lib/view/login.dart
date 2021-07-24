import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hackerapp/Api/api_methods.dart';
import 'package:hackerapp/modal/login_response.dart';
import 'package:hackerapp/sharedprefs/shared_pref.dart';
import 'package:hackerapp/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  // String? email;
  // Login({this.email});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email = '', password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 200, right: 40, left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.blueGrey[50],
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  cursorColor: Colors.orange[200],
                  decoration: InputDecoration(
                    hintText: 'email@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.blueGrey[50],
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: [AutofillHints.email],
                  cursorColor: Colors.orange[200],
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'enter password',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: MaterialButton(
                  onPressed: () async {
                    var res = await ApiCall().userlogin(email!, password!);
                    LoginResponse loginResponse =
                        LoginResponse.fromJson(res.toJson());
                    AppSharedPreference().saveEmail(email!);

                    if (res.token != null) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("email", email!);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    emailid: email,
                                  )));
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
