import 'package:flutter/material.dart';
import 'package:notes/providers/folder_provider.dart';
import 'package:notes/providers/note_provider.dart';
import 'package:notes/screens/folder_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FolderProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: MaterialApp(
        title: 'App de Notas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FolderListScreen(),
      ),
    );
  }
}
