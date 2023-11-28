import 'package:flutter/material.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void loadNotes(int folderId) async {
    var dbService = DatabaseService();
    _notes = await dbService.getNotes(folderId);
    notifyListeners();
  }

  void addNote(Note note) async {
    var dbService = DatabaseService();
    await dbService.insertNote(note);
    loadNotes(note.folderId);
  }
}
