import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';


class NoteListScreen extends StatelessWidget {
  final int folderId;

  NoteListScreen({required this.folderId});

  @override
  Widget build(BuildContext context) {
    Provider.of<NoteProvider>(context, listen: false).loadNotes(folderId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              Note note = noteProvider.notes[index];
              return ListTile(
                title: Text(note.title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteDetailScreen(note: note),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen(folderId: folderId)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
