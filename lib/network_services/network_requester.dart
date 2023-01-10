import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkRequester {
  /// get method
  Future getRequest(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Request failed');
      }
    } catch (e) {
      print(e);
    }
  }

  /// post method
  Future postRequest(String url, Map<String, String> body) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url),
              headers: {"Content-type": "application/json", "Accept": "application/json"},
              body: jsonEncode(body));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Request failed');
      }
    } catch (e) {
      print(e);
    }
  }
}
