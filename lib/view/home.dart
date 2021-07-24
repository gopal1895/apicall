import 'package:flutter/material.dart';
import 'package:hackerapp/sharedprefs/shared_pref.dart';
import 'package:hackerapp/view/dhashboard.dart';
import 'package:hackerapp/view/login.dart';
import 'package:hackerapp/view/photo.dart';
import 'package:hackerapp/view/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final String? emailid;
  const HomePage({Key? key, this.emailid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email = '';
  String? name = "Hacker";
  getEmail() async {
    String? emailid = await AppSharedPreference().getEmail();
    setState(() {
      email = emailid;
    });
  }

  Future<void> getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString("email");
    });
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    super.initState();
    getEmail();
    print("email");
    print(email);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name!),
                      Text(
                        widget.emailid!,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(),
                ),
                ListTile(
                  title: Text("Dashboard"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                ),
                ListTile(
                  title: Text("Logout"),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("email", '');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Hacker App'),
            bottom: TabBar(
              tabs: [Tab(text: "Photo"), Tab(text: "Post")],
            ),
          ),
          body: TabBarView(
            children: [
              Photo(),
              PostData(),
            ],
          ),
        ),
      ),
    );
  }
}
