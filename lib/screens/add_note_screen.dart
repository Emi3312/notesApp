/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';

class AddNoteScreen extends StatelessWidget {
  final int folderId;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

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
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Ubicación'),
              readOnly: true,
            ),
            ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                _locationController.text = '${position.latitude}, ${position.longitude}';
              },
              child: Text('Obtener Ubicación Actual'),
            ),
            ElevatedButton(
              onPressed: () {
                final String title = _titleController.text;
                final String content = _contentController.text;
                final String location = _locationController.text;
                if (title.isNotEmpty) {
                  final note = Note(
                    title: title,
                    content: content,
                    location: location,
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

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación fueron denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Los permisos de ubicación fueron permanentemente denegados, no podemos solicitar permisos.');
    } 

    return await Geolocator.getCurrentPosition();
  }
}

*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import '../models/note.dart';
import '../providers/note_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;

class AddNoteScreen extends StatefulWidget {
  final int folderId;

  AddNoteScreen({required this.folderId});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  Uint8List? _photo;

  Future<Uint8List> _resizePhoto(String path, {int width = 500}) async {
    File imageFile = File(path);

    img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());
    img.Image resizedImage = img.copyResize(originalImage!, width: width);

    return Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación fueron denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Los permisos de ubicación fueron permanentemente denegados, no podemos solicitar permisos.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _takePhoto() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

  if (photo != null) {
    Uint8List resizedPhoto = await _resizePhoto(photo.path);
    setState(() {
      _photo = resizedPhoto;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Nota'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Contenido'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Ubicación'),
              readOnly: true,
            ),
            ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();
                _locationController.text =
                    '${position.latitude}, ${position.longitude}';
              },
              child: Text('Obtener Ubicación Actual'),
            ),
            if (_photo != null) Image.memory(_photo!),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Tomar Foto'),
            ),
            ElevatedButton(
              onPressed: () {
                final String title = _titleController.text;
                final String content = _contentController.text;
                final String location = _locationController.text;
                if (title.isNotEmpty) {
                  final note = Note(
                    title: title,
                    content: content,
                    location: location,
                    photo: _photo,
                    folderId: widget.folderId,
                  );
                  Provider.of<NoteProvider>(context, listen: false)
                      .addNote(note);
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
