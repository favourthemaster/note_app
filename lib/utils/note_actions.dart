import 'package:flutter/material.dart';
import 'package:noted/utils/providers/note_provider.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';

void saveNote(BuildContext context,
    {required Note note, required String content, required String title}) {
  List<Note> notes = context.read<NoteProvider>().getNotes();
  if (notes.contains(note)) {
    context
        .read<NoteProvider>()
        .saveNote(note: note, content: content, title: title);
  } else {
    if (title.isNotEmpty) {
      context
          .read<NoteProvider>()
          .saveNewNote(note: note, content: content, title: title);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            dismissDirection: DismissDirection.horizontal,
            behavior: SnackBarBehavior.floating,
            width: MediaQuery.of(context).size.width - 60,
            backgroundColor: const Color.fromRGBO(35, 39, 48, 1.0),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "You need to give the note a valid name",
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                ),
              ],
            )),
      );
    }
  }
}

void deleteNote(BuildContext context, Note note) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Are you sure you want to delete this note?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<NoteProvider>().deleteSingleNote(note);
              Navigator.pop(context);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
      ],
    ),
  );
}

void deleteNotes(BuildContext context, List<Note> notes) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: notes.length > 1
          ? const Text("Are you sure you want to delete these notes?")
          : const Text("Are you sure you want to delete this note?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<NoteProvider>().deleteMultipleNotes(notes);
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
      ],
    ),
  );
}
