class Note {
  String name;
  String _content = "";
  DateTime _lastModified = DateTime.now();
  bool isSelected = false;
  Note({required this.name});

  factory Note.fromJson(Map<String, dynamic> json) {
    Note n = Note(
      name: json['name'],
    );
    n.setContent(json['content']);
    if (json['lastModified'] != null) {
      n.setLastModifiedFromJson(DateTime.parse(json['lastModified']));
    }
    return n;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'content': getContent(),
      'lastModified': getLastModifiedTime().toString(),
    };
  }

  void setContent(String content) {
    _content = content;
  }

  void setLastModified() {
    _lastModified = DateTime.now();
  }

  void setLastModifiedFromJson(DateTime dt) {
    _lastModified = dt;
  }

  String getContent() {
    return _content;
  }

  DateTime getLastModifiedTime() {
    return _lastModified;
  }
}
