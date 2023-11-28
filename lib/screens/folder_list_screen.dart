import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/folder_provider.dart';
import '../models/folder.dart';
import 'add_folder_screen.dart';
import 'note_list_screen.dart';

class FolderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<FolderProvider>(context, listen: false).loadFolders();
    return Scaffold(
      appBar: AppBar(
        title: Text('Carpetas'),
      ),
      body: Consumer<FolderProvider>(
        builder: (context, folderProvider, child) {
          return ListView.builder(
            itemCount: folderProvider.folders.length,
            itemBuilder: (context, index) {
              Folder folder = folderProvider.folders[index];
              return ListTile(
                title: Text(folder.name),
                onTap: () => _showPasswordDialog(context, folder),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFolderScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void _showPasswordDialog(BuildContext context, Folder folder) {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Ingrese la Contraseña'),
          content: TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Entrar'),
              onPressed: () {
                if (_passwordController.text == folder.password) {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteListScreen(folderId: folder.id!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contraseña incorrecta')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
