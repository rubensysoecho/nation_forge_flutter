import '../core/api_service.dart';
import '../models/nation.dart';

class NationRepository {
  final ApiService _apiService = ApiService();

  Future<List<Nation>> getNations() => _apiService.fetchNations();

  Future<Nation> createNation(String nationName, String governmentType, String age) => _apiService.createNation(nationName, governmentType, age);
}