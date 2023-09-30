import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClient {
  ApiClient._();

  static final ApiClient _instance = ApiClient._();

  static ApiClient get client => _instance;

  final String _baseUrl = 'https://dummyjson.com/';

  Map<String, String> get headers {
    var map = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    return map;
  }

  Future<dynamic> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(_baseUrl + url);
      
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 120));
     if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return Future.error(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
