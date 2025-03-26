import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:nation_forge/models/war.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/nation.dart';

class WarApiService {
  static const String prodID = 'nation-forge-backend.onrender.com';
  static const String baseUrl = 'http://${prodID}/api/war';

  Future<String> userId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = await prefs.getString('user_id');
    return userId!;
  }

  Future<List<War>> fetchWars() async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {'userId': await userId()});
    final response = await http.get(uri);
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
      "optionalPrompt": "",
      "userId": await userId(),
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
