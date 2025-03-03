import '../core/api_service.dart';
import '../models/nation.dart';

class NationRepository {
  final ApiService _apiService = ApiService();

  Future<List<Nation>> getNations() => _apiService.fetchNations();

  Future<Nation> createNation(Nation nation) => _apiService.createNation(nation);
}