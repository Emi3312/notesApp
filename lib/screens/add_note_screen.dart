import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class AddNoteScreen extends StatelessWidget {
  final int folderId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  AddNoteScreen({required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Nota'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Contenido'),
            ),
            ElevatedButton(
              onPressed: () {
                final String title = _titleController.text;
                final String content = _contentController.text;
                if (title.isNotEmpty) {
                  final note = Note(
                    title: title,
                    content: content,
                    folderId: folderId,
                  );
                  Provider.of<NoteProvider>(context, listen: false).addNote(note);
                  Navigator.pop(context);
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
