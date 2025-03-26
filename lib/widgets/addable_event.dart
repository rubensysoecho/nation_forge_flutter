import 'package:flutter/material.dart';

class AddableEvent extends StatefulWidget {
  final IconData icon;
  final String text;
  final String? details;
  const AddableEvent({
    super.key,
    required this.icon,
    required this.text,
    this.details,
  });

  @override
  State<AddableEvent> createState() => _AddableEventState();
}

class _AddableEventState extends State<AddableEvent> {

  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        leading: Icon(widget.icon),
        title: Text(
          widget.text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: widget.details != null
            ? Text(widget.details!)
            : null,
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
