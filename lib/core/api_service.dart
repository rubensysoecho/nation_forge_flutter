import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nation_forge/models/war.dart';
import '../models/nation.dart';

class ApiService {
  static const String devIp = '10.0.2.16';
  static const String prodID = 'nation-forge-backend.onrender.com';
  static const String baseUrl = 'http://${prodID}/api/nation';
  static const String warBaseUrl = 'http://${prodID}/api/war';

  Future<List<Nation>> fetchNations() async {
    final response = await http.get(Uri.parse(baseUrl));
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
      "age": age
    };

    final response = await http.post(
      Uri.parse('http://${prodID}/api/nation/gemini'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(nationData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Nation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create nation');
    }
  }

  Future<List<War>> fetchWars() async {
    final response = await http.get(Uri.parse(warBaseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) => War.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load nations');
    }
  }

  Future<War> createWar(String nationA, String nationB, String casusBelli, String age) async {
    final Map<String, dynamic> warData = {
      "nationA": nationA,
      "nationB": nationB,
      "casusBelli": casusBelli,
      "age": age,
      "optionalPrompt": ""
    };

    final response = await http.post(
      Uri.parse('https://${prodID}/api/war/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(warData),
    );
    if (response.statusCode == 201 || response.statusCode == 200 || response.statusCode == 307) {
      return War.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create war');
    }
  }
}
