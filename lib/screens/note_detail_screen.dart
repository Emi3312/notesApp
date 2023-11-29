import 'package:flutter/material.dart';
import 'dart:typed_data';
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
              Text(note.content!, style: TextStyle(fontSize: 25.0)),
            if (note.photo != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.memory(note.photo!),
              ),
            if (note.location != null && note.location!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Ubicación: ${note.location}',
                  style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
