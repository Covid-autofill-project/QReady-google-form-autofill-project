import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void request() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url =
      Uri.parse("https://www.google.com/");
  // Await the http get response, then decode the json-formatted response.
  var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

}