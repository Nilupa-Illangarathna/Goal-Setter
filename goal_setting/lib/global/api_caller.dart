import 'dart:convert';
import 'package:http/http.dart' as http;
import './global_settings.dart';

class ApiCaller {
  final String baseUrl;

  ApiCaller({required this.baseUrl});

  Future<Map<String, dynamic>?> callApi(String route, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$route'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Failed to call API: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception while calling API: $e');
      return null;
    }
  }
}

// Instantiate a global object
ApiCaller apiCaller = ApiCaller(baseUrl: globalData.baseUrlRoute);
