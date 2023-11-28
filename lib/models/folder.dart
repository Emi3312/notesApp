class Folder {
  int? id;
  String name;
  String password;

  Folder({this.id, required this.name, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'folder_id': id,
      'name': name,
      'password': password,
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['folder_id'],
      name: map['name'],
      password: map['password'],
    );
  }
}
