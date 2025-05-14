import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/nation/nation.dart';
import '../../models/nation/nation_sketch.dart';

class ApiService {
  static const String prodID = 'nation-forge-backend.onrender.com';
  static const String devID = 'nation-forge-backend-dev.onrender.com';
  static const String baseUrl = 'https://$devID/api/nation/';

  // TODO: Almacena tu clave API de OpenAI de forma segura. No la codifiques directamente aquí en producción.
  static const String _openAiApiKey = 'TU_CLAVE_API_DE_OPENAI_AQUI';
  static const String _openAiBaseUrl = 'https://api.openai.com/v1';

  Future<String> userId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
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

  Future<List<NationSketch>> fetchNationSketches() async {
    final uri = Uri.parse('$baseUrl/simple/${await userId()}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<NationSketch> nations = data.map((e) => NationSketch.fromJson(e)).toList();
      return nations.reversed.toList();
    } else {
      throw Exception('Failed to load nation sketches');
    }
  }

  Future<Nation> fetchNation(String nationId) async {
    final uri = Uri.parse('$baseUrl/details/$nationId');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final nation = json.decode(response.body);
      return Nation.fromJson(nation);
    } else if (response.statusCode == 404) {
      throw Exception('Nation not found');
    } else {
      throw Exception('Failed to load nation');
    }
  }

  Future<Nation> createRandomNation() async {
    final Map<String, dynamic> nationData = {
      "userId": await userId(),
    };

    final response = await http.post(
      Uri.parse('$baseUrl/random'),
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

  Future<Nation> createNation(
    String nationName,
    String governmentType,
    String age,
  ) async {
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

  Future<Nation> createNationAdvanced(
    String nationName,
    String governmentType,
    String age,
    String leaderName,
    double politicalStability,
    String economicSystem,
    String currencyName,
    double wealthDistribution,
    String lifeExpectancy,
    double populationGrowth,
    String other,
  ) async {
    final Map<String, dynamic> nationData = {
      "nationName": nationName,
      "governmentType": governmentType,
      "age": age,
      "leaderName": leaderName,
      "politicalStability": politicalStability,
      "economicSystem": economicSystem,
      "currencyName": currencyName,
      "wealthDistribution": wealthDistribution,
      "lifeExpectancy": lifeExpectancy,
      "populationGrowth": populationGrowth,
      "userId": await userId(),
      "advanced": true,
      "other": other,
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

  Future<bool> deleteNation(String nationId) async {
    final uri = Uri.parse('$baseUrl/$nationId');

    final response = await http.delete(uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': await userId()}));

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('Nation not found');
    } else if (response.statusCode == 403) {
      throw Exception('Unauthorized');
    } else if (response.statusCode == 500) {
      throw Exception('Server error');
    } else {
      throw Exception('Failed to delete nation');
    }
  }

  Future<String> generateOpenAiImage(String prompt) async {
    final uri = Uri.parse('$_openAiBaseUrl/images/generations');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_openAiApiKey',
    };
    final body = json.encode({
      'model': 'gpt-image-1',
      'prompt': prompt,
      'n': 1,
      'size': '1024x1024',
      'quality': 'medium',
    });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Asumiendo que la API devuelve la URL de la imagen en data[0].url
      return data['data'][0]['url'];
    } else {
      // Considera un manejo de errores más detallado basado en los códigos de estado de OpenAI
      print('Error en la API de OpenAI: ${response.body}');
      throw Exception('Failed to generate image from OpenAI');
    }
  }
}
