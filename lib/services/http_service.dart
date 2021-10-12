import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// some code from: https://medium.com/solidmvp-africa/making-your-api-calls-in-flutter-the-right-way-f0a03e35b4b1

Future<List<dynamic>> getData(String url) async {
  try {
    http.Response res = await http.get(Uri.parse(url));
    return _returnResponse(res);

    // if (res.statusCode == 200) {
    //   return jsonDecode(res.body);
    // } else {
    //   print('ERROR.... ${res.statusCode}');
    //   throw Exception('Error retrieving users... try block');
    // }
  } on SocketException {
    // ignore: avoid_print
    print('Check internet connection or URL');
    throw Exception('Check internet connection.');
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return json.decode(response.body);
    case 400:
      throw Exception('Bad Request: ' + response.body.toString());
    case 401:
    case 403:
      throw Exception('Unauthorised: ' + response.body.toString());
    case 500:
    default:
      throw Exception(
          'Error occurred while communicating with Server with StatusCode: ${response.statusCode}');
  }
}