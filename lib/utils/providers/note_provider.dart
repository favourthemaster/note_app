import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/note_model.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _notesAfterSearch = [];

  List<Note> getNotes() {
    return _notes
      ..sort(
          (a, b) => b.getLastModifiedTime().compareTo(a.getLastModifiedTime()));
  }

  void deleteSingleNote(Note note) {
    _notes.remove(note);
    _saveEverything();
    setNotesAfterSearch("");
    notifyListeners();
  }

  void deleteMultipleNotes(List<Note> notes) {
    for (int i = 0; i < notes.length; i++) {
      _notes.remove(notes[i]);
    }
    setNotesAfterSearch("");
    _saveEverything();
    notifyListeners();
  }

  void saveNote(
      {required Note note, required String content, required String title}) {
    note.name = title;
    note.setContent(content);
    note.setLastModified();
    setNotesAfterSearch("");
    _saveEverything();
    notifyListeners();
  }

  void saveNewNote(
      {required Note note, required String content, required String title}) {
    note.name = title;
    note.setContent(content);
    note.setLastModified();
    _notes.add(note);
    setNotesAfterSearch("");
    _saveEverything();
    notifyListeners();
  }

  void toggleSelection(Note note) {
    note.isSelected = !note.isSelected;
    notifyListeners();
  }

  Future<void> _saveEverything() async {
    final prefs = await SharedPreferences.getInstance();
    String notesJson = jsonEncode(_notes.map((note) => note.toJson()).toList());
    prefs.setString('notes', notesJson);
  }

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    String? notesJson = prefs.getString('notes');
    if (notesJson != null) {
      _notes = jsonDecode(notesJson)
          .map<Note>((jsonNote) => Note.fromJson(jsonNote))
          .toList();
      _notesAfterSearch = _notes;
      notifyListeners();
      return _notes;
    } else {
      return [];
    }
  }

  void setNotesAfterSearch(String query) {
    if (query.isNotEmpty) {
      _notesAfterSearch =
          getNotes().where((note) => note.name.contains(query)).toList();
    } else {
      _notesAfterSearch = _notes;
    }
    notifyListeners();
  }

  List<Note> getNotesAfterSearch() {
    return _notesAfterSearch;
  }
}
