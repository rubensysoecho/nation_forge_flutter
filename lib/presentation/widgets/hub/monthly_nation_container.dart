import 'package:flutter/material.dart';
import 'package:nation_forge/data/models/nation/nation_sketch.dart';
import 'package:nation_forge/presentation/views/nation/details/nation_sketch_detail.dart'; // Asegúrate de que la ruta de importación sea correcta

class MonthlyNationContainer extends StatelessWidget {
  final NationSketch nation;
  final String? creatorId;

  const MonthlyNationContainer({
    super.key,
    required this.nation,
    this.creatorId,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos un Card para darle un aspecto de contenedor con sombra y bordes redondeados.
    return Card(
      elevation: 4.0, // Sombra del card
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Margen exterior
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Bordes redondeados más pronunciados
      ),
      child: Container(
        width: 300, // Ancho fijo para el contenedor
        padding: const EdgeInsets.all(16.0), // Aumentar espaciado interno
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Imagen
            AspectRatio(
              aspectRatio: 16 / 9, // Proporción más panorámica para la imagen
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://elordenmundial.com/wp-content/uploads/2024/04/por-que-bandera-reino-unido-se-llama-union-jack-.jpg', // Usar nation.imageUrl si existe, sino placeholder
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.broken_image,
                        size: 40, // Icono un poco más pequeño
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Aumentar espacio

            // Título
            Text(
              nation.nationName,
              style: const TextStyle(
                fontSize: 20.0, // Título más grande
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8.0), // Espacio antes del creador

            // Creador
            Text(
              'Creador: ${creatorId ?? 'Desconocido'}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700], // Color más suave para el creador
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0), // Aumentar espacio antes del botón

            // Botón "Ver"
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NationSketchDetailPage(
                      sketch: nation,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                shape: RoundedRectangleBorder( // Botón con bordes redondeados
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Ver Detalles'), // Texto del botón más descriptivo
            ),
          ],
        ),
      ),
    );
  }
}
