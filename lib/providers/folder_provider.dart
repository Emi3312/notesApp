import 'package:flutter/material.dart';
import '../models/folder.dart';
import '../services/database_service.dart';

class FolderProvider with ChangeNotifier {
  List<Folder> _folders = [];

  List<Folder> get folders => _folders;

  FolderProvider() {
    loadFolders();
  }

  void loadFolders() async {
    var dbService = DatabaseService();
    _folders = await dbService.getFolders();
    notifyListeners();
  }

  void addFolder(Folder folder) async {
    var dbService = DatabaseService();
    await dbService.insertFolder(folder);
    loadFolders();
  }
}
