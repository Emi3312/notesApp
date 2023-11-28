import 'package:flutter/material.dart';
import '../models/note.dart';


class NoteDetailScreen extends StatelessWidget {
  final Note note;

  NoteDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            if (note.content != null && note.content!.isNotEmpty)
              Text(
                note.content!,
                style: TextStyle(fontSize: 22.0),
              ),
            // Aquí puedes añadir más detalles como la ubicación y la foto si están disponibles
          ],
        ),
      ),
    );
  }
}
