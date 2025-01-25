import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchdata(String url) async {
 final response = await http.get(Uri.parse(url));

 if (response.statusCode == 200) {
  // Successful response, parse JSON
  return jsonDecode(response.body);
 } else if (response.statusCode == 401) {
  // Incorrect credentials
  return {"error": "Incorrect credentials"};
 } else {
  // Other errors
  return {"error": "Something went wrong"};
 }
}
