import 'package:flutter/material.dart';
import 'package:hackerapp/view/home.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HomePage()));
                Navigator.pop(context);
              },
              icon: Image.asset('assets/icons/four_dot.png')),
          title: Text(
            "Dashboard",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: IconButton(
                    //color: Colors.black,
                    onPressed: () {},
                    icon: Image.asset('assets/icons/photo.png')),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Text("data"),
          ),
          Container(
            height: 300,
            //width: 250,
            child: PageView.builder(
              itemCount: 10,
              //controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (_, i) {
                return Transform.scale(
                  scale: i == _index ? 1 : 0.9,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Card ${i + 1}",
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            child: Text(
              "video",
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 200,
            //width: 250,
            child: PageView.builder(
              itemCount: 10,
              //controller: PageController(viewportFraction: 0.7),
              onPageChanged: (int index) => setState(() => _index = index),
              itemBuilder: (_, i) {
                return Transform.scale(
                  scale: i == _index ? 1 : 0.9,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Card ${i + 1}",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_label_sharp),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}
