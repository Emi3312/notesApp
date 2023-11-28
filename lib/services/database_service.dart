import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/folder.dart';
import '../models/note.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'note_app.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE folders (
            folder_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            password TEXT NOT NULL
        );
      ''');
      await db.execute('''
        CREATE TABLE notes (
            note_id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT,
            location TEXT,
            photo BLOB, 
            folder_id INTEGER,
            FOREIGN KEY (folder_id) REFERENCES folders(folder_id)
        );
      ''');
    });
  }

  Future<List<Folder>> getFolders() async {
    final db = await database;
    var folders = await db.query('folders');
    return List.generate(folders.length, (i) {
      return Folder.fromMap(folders[i]);
    });
  }

  Future<void> insertFolder(Folder folder) async {
    final db = await database;
    await db.insert(
      'folders',
      folder.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getNotes(int folderId) async {
    final db = await database;
    var notes = await db.query('notes', where: 'folder_id = ?', whereArgs: [folderId]);
    return List.generate(notes.length, (i) {
      return Note.fromMap(notes[i]);
    });
  }

  Future<void> insertNote(Note note) async {
    final db = await database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
