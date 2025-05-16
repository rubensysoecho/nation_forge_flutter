import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nation_forge/data/models/nation/nation_sketch.dart';

class HubNationCard extends StatelessWidget {
  final NationSketch nationSketch;

  const HubNationCard({Key? key, required this.nationSketch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0), // Margen ajustado
      clipBehavior: Clip.antiAlias, // Para que el BoxDecoration respete el borde redondeado
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        // Usar un gradiente o una imagen de fondo podría ser visualmente atractivo
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[700]!, Colors.blueGrey[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                nationSketch.nationName,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(), // Empuja el botón hacia abajo
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[400], // Un color que contraste
                  foregroundColor: Colors.black87,
                ),
                child: Text('Ver Detalles'),
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: 'Ver detalles de ${nationSketch.nationName}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}