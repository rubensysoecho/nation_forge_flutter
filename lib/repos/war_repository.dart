import '../core/api_service.dart';
import '../models/war.dart';

class WarRepository {
  final ApiService _apiService = ApiService();

  Future<List<War>> getWars() => _apiService.fetchWars();
  Future<War> createWar(String nationA, String nationB, String casusBelli, String age) => _apiService.createWar(nationA, nationB, casusBelli, age);
}