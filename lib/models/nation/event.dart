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
    DateTime parsedDate;
    try {
      // Intentar parsear la fecha normalmente
      parsedDate = DateTime.parse(json['date']);
    } catch (e) {
      // Si falla, intentar corregir formatos incorrectos
      String dateStr = json['date'].toString();
      
      // Corregir años con menos de 4 dígitos
      if (dateStr.contains('-') && dateStr.split('-')[0].length < 4) {
        final parts = dateStr.split('-');
        // Añadir ceros al principio para completar 4 dígitos
        parts[0] = parts[0].padLeft(4, '0');
        dateStr = parts.join('-');
        try {
          parsedDate = DateTime.parse(dateStr);
        } catch (_) {
          // Si todavía falla, usar fecha por defecto
          parsedDate = DateTime(1970, 1, 1);
        }
      } else {
        // Si el formato es completamente irreconocible, usar fecha por defecto
        parsedDate = DateTime(1970, 1, 1);
      }
    }

    return Event(
      id: json['_id'],
      title: json['title'],
      type: json['type'],
      description: json['description'],
      date: parsedDate,
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