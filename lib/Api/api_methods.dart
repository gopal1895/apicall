import 'dart:convert';

import 'package:hackerapp/modal/login_response.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<LoginResponse> userlogin(String email, String password) async {
    final http.Response response =
        await http.post(Uri.parse('https://reqres.in/api/login'),
            // headers: <String, String>{
            //   'Accept': 'application/json',
            // },
            body: {
          'email': email,
          'password': password,
        });

    if (response.statusCode == 200) {
      print(response.body);
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
