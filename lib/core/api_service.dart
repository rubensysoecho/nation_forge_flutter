import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/nation.dart';

class ApiService {
  static const String deviceIp = '172.26.123.24';
  static const String baseUrl = 'http://${deviceIp}:4000/api/nation';

  Future<List<Nation>> fetchNations() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => Nation.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load nations');
    }
  }

  Future<Nation> createNation(Nation nation) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nation.toJson()),
    );
    if (response.statusCode == 201) {
      return Nation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create nation');
    }
  }
}
