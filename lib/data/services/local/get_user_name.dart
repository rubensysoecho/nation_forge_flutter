import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> getNameFromFirestore(String uid) async {
  try {
    final DocumentSnapshot userDocument =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!userDocument.exists) {
      print("No se encontró ningún documento de usuario con el UID: $uid.");
      return null;
    }

    // El documento existe, ahora revisa sus datos.
    final Map<String, dynamic>? data = userDocument.data() as Map<String, dynamic>?;

    if (data == null) {
      // Este caso significa que el documento existe pero no tiene campos (está vacío).
      print("Los datos del documento para el UID: $uid son nulos (documento vacío), aunque el documento existe.");
      return null;
    }

    if (!data.containsKey('name')) {
      print("El documento del usuario con UID: $uid no contiene el campo 'username'.");
      return null;
    }

    final nameValue = data['name'];

    if (nameValue is String) {
      return nameValue;
    }

    if (nameValue == null) {
      // El campo 'name' existe pero su valor es explícitamente nulo.
      print("El campo 'name' es nulo en Firestore para el UID: $uid.");
      return null;
    }
    
    // El campo 'name' existe pero no es un String y tampoco es nulo.
    print("El campo 'name' para el UID: $uid no es de tipo String (tipo encontrado: ${nameValue.runtimeType}).");
    return null;

  } catch (e) {
    print("Error al obtener el nombre de usuario desde Firestore para UID: $uid. Error: $e");
    return null;
  }
}