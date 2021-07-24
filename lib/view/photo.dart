import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  // final response =
  //     await http.get('https://jsonplaceholder.typicode.com/albums');
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final int? id;
  final String title;

  final String url;

  Data({this.id, required this.title, required this.url});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(id: json['id'], title: json['title'], url: json['url']);
  }
}

class Photo extends StatefulWidget {
  Photo({Key? key}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  late Future<List<Data>> futureData;
  String? img_url;
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
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          img_url = data[index].url;
                          openImageDialog(context);
                        },
                        child: Container(
                          height: 80,
                          width: 50,
                          child: Image.network(data[index].url),
                        ),
                      ),
                      title: Text(
                        data[index].title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // child: Container(
                  //   height: 500,
                  //   child: Column(
                  //     children: [
                  //       Text(data[index].title),
                  //       Container(
                  //         child: data[index].url != null
                  //             ? Image.network(data[index].url)
                  //             : Text("image not found"),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future openImageDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 400,
              child: Image.network(img_url!),
            ),
          );
        });
  }
}
