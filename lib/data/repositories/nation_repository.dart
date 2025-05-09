import 'package:nation_forge/data/models/nation/nation_sketch.dart';

import '../services/api/nation_api_service.dart';
import '../models/nation/nation.dart';

class NationRepository {
  final ApiService _apiService = ApiService();

  Future<List<Nation>> getNations() => _apiService.fetchNations();
  Future<List<NationSketch>> getNationSketches() => _apiService.fetchNationSketches();
  Future<Nation> getNationDetails(String nationId) =>
      _apiService.fetchNation(nationId);

  Future<Nation> createNation(
    String nationName,
    String governmentType,
    String age,
  ) =>
      _apiService.createNation(nationName, governmentType, age);

  Future<Nation> createRandomNation() => _apiService.createRandomNation();

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
  ) =>
      _apiService.createNationAdvanced(nationName, governmentType, age, 
          leaderName, politicalStability, economicSystem, currencyName,
          wealthDistribution, lifeExpectancy, populationGrowth, other);

  Future<bool> deleteNation(String nationId) =>
      _apiService.deleteNation(nationId);

}
