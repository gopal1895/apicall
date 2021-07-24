import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  // final response =
  //     await http.get('https://jsonplaceholder.typicode.com/albums');
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Data>> fetchOne() async {
  // final response =
  //     await http.get('https://jsonplaceholder.typicode.com/albums');
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/{index}'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final int? userId;
  final int? id;
  final String title;
  final String body;

  Data({this.userId, this.id, required this.title, required this.body});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class PostData extends StatefulWidget {
  PostData({Key? key}) : super(key: key);

  @override
  _PostDataState createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  late Future<List<Data>> futureData;
  int? dynamicIndex;
  String? title, body;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Data>? data = snapshot.data;
          return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    dynamicIndex = data[index].id;
                    title = data[index].title;
                    body = data[index].body;
                    openCardDialog(context);
                  },
                  child: Card(
                    color: Colors.cyan[100],
                    elevation: 5,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(child: Text(data[index].body)),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future openCardDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 400,
              child: Column(
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Text(body!))
                ],
              ),
            ),
          );
        });
  }
}
