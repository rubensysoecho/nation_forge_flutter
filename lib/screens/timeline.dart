import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nation_forge/widgets/addable_event.dart';

import '../app_theme.dart';

import '../models/event.dart';

class Timeline extends StatelessWidget {
  final List<Event> events;
  final String nationName;

  const Timeline({Key? key, required this.events, required this.nationName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _buildTimelineSection(context),
            ),
          ),
          //_buildCarousel(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Draggable(
              feedback: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.add)),
              child: AddableEvent(
                icon: Icons.account_circle_rounded,
                text: 'Plaga',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineSection(BuildContext context) {
    if (events.isEmpty) {
      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No hay eventos históricos disponibles para esta nación.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Timeline de Eventos Históricos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: events.length * 150.0,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                left: 24,
                child: Container(
                  width: 2.0,
                  color: Colors.grey[400],
                ),
              ),
              ...events.asMap().entries.map((entry) {
                final int index = entry.key;
                Event event = entry.value;
                return Positioned(
                  top: index * 150.0, // Espacio entre tarjetas
                  left: 0,
                  right: 0,
                  child: _buildTimelineEventCard(
                      context, event, index, events.length),
                );
              }),
            ],
          ),
        ),
        /*DragTarget<String>(
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text('Añada aqui su evento')),
            );
          },
          onAcceptWithDetails: (details) {
            context.read<NationBloc>().add(AddEvent('type', ''));
          },
        ),*/
      ],
    );
  }

  Widget _setIcon(Event e) {
    switch (e.type) {
      case "foundation":
        return Icon(Icons.foundation, color: Colors.white, size: 24);
      case "political":
        return Icon(Icons.account_balance, color: Colors.white, size: 24);
      case "war":
        return Icon(Icons.sports, color: Colors.white, size: 24);
      case "treaty":
        return Icon(Icons.handshake, color: Colors.white, size: 24);
      case "natural disaster":
        return Icon(Icons.thunderstorm, color: Colors.white, size: 24);
      case "plague":
        return Icon(Icons.coronavirus, color: Colors.white, size: 24);
      default:
        return Icon(Icons.event, color: Colors.white, size: 24);
    }
  }

  Widget _buildTimelineEventCard(BuildContext context, Event event, int index, int totalEvents) {
    return Row(
      children: [
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryColor,
          ),
          child: Center(
            child: _setIcon(event),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          event.description,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${event.date.day} de ${getMonth(event.date.month)}, ${event.date.year}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "Enero";
      case 2:
        return "Febrero";
      case 3:
        return "Marzo";
      case 4:
        return "Abril";
      case 5:
        return "Mayo";
      case 6:
        return "Junio";
      case 7:
        return "Julio";
      case 8:
        return "Agosto";
      case 9:
        return "Septiembre";
      case 10:
        return "Octubre";
      case 11:
        return "Noviembre";
      case 12:
        return "Diciembre";
      default:
        return "Mes inválido";
    }
  }
}
