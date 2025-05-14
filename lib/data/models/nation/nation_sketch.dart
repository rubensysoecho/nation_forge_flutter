

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