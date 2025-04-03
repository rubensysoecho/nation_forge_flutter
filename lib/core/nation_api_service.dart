import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:nation_forge/models/war/war.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/nation/nation.dart';

class ApiService {
  static const String prodID = 'nation-forge-backend.onrender.com';
  static const String devID = 'nation-forge-backend-dev.onrender.com';
  static const String baseUrl = 'https://${prodID}/api/nation/';

  Future<String> userId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = await prefs.getString('user_id');
    return userId!;
  }

  Future<List<Nation>> fetchNations() async {
    final uri = Uri.parse('$baseUrl/${await userId()}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Nation> nations = data.map((e) => Nation.fromJson(e)).toList();
      return nations.reversed.toList();
    } else {
      throw Exception('Failed to load nations');
    }
  }

  Future<Nation> createNation(String nationName, String governmentType, String age) async {
    final Map<String, dynamic> nationData = {
      "nationName": nationName,
      "governmentType": governmentType,
      "age": age,
      "userId": await userId()
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nationData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final nation = json.decode(response.body)['nation'];
      return Nation.fromJson(nation);
    } else {
      throw Exception('Failed to create nation');
    }
  }

  /*Future<String> loginUser(String email, String password) async {
    final url = Uri.parse('https://${prodID}/api/user/login');
    String loginToken = "";

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        loginToken = jsonDecode(response.body)['user']['token'];
      }
    } catch (e) {
      throw Exception('Error login');
    }
    return loginToken;
  }*/
}
