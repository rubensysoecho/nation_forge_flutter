import '../core/war_api_service.dart';
import '../models/war.dart';

class WarRepository {
  final WarApiService _apiService = WarApiService();

  Future<List<War>> getWars() => _apiService.fetchWars();
  Future<War> createWar(String nationA, String nationB, String casusBelli, String age) => _apiService.createWar(nationA, nationB, casusBelli, age);
}