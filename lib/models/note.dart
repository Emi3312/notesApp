import 'dart:typed_data';

class Note {
  int? id;
  String title;
  String? content;
  String? location;
  Uint8List? photo;
  int folderId;

  Note({
    this.id,
    required this.title,
    this.content,
    this.location,
    this.photo,
    required this.folderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'note_id': id,
      'title': title,
      'content': content,
      'location': location,
      'photo': photo,
      'folder_id': folderId,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['note_id'],
      title: map['title'],
      content: map['content'],
      location: map['location'],
      photo: map['photo'],
      folderId: map['folder_id'],
    );
  }
}
