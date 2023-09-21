import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

fetchdata(String url) async{
  http.Response response = await http.get(Uri.parse(url));
  return response.body;
}

postdata(String url, int id, String name, String details) async{

  Map data = {
    'details': details,
    'id': id,
    'name': name
  };

  var body = json.encode(data);

  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: body
  );
  return response;
}