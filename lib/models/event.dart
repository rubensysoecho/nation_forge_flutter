class Event {
  final String id;
  final String title;
  final String type;
  final String description;
  final DateTime date;

  Event({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['_id'],
      title: json['title'],
      type: json['type'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'type': type,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  // Método para crear una copia con algunos campos modificados
  Event copyWith({
    String? title,
    String? type,
    String? description,
    DateTime? date,
  }) {
    return Event(
      id: id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}