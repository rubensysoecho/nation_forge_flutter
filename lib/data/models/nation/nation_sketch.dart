import 'package:nation_forge/data/models/nation/event.dart';
import 'package:nation_forge/data/models/nation/politics_details.dart';
import 'package:nation_forge/data/models/nation/economy_details.dart';
import 'package:nation_forge/data/models/nation/population_details.dart';

import 'nation.dart';

class NationSketch {
  final String id;
  final String nationName;

  NationSketch({
    required this.id,
    required this.nationName,
  });

  factory NationSketch.fromJson(Map<String, dynamic> json) {
    return NationSketch(
      id: json['_id'],
      nationName: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'nationName': nationName,
    };

    return data;
  }
}