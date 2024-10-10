import 'package:flutter/material.dart';
import 'package:noted/utils/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/note_model.dart';
import '../utils/note_actions.dart';

class NoteEditPage extends StatelessWidget {
  final Note note;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  NoteEditPage({super.key, required this.note});

  List<Widget> buildActions(Note note, BuildContext context) {
    bool isNoteExists = context.read<NoteProvider>().getNotes().contains(note);
    if (isNoteExists) {
      return [
        IconButton(
          onPressed: () {
            saveNote(context,
                title: titleController.text,
                content: contentController.text,
                note: note);
            if (titleController.text == note.name &&
                contentController.text == note.getContent() &&
                note.name.isNotEmpty) {
              Share.share("${titleController.text}\n${contentController.text}");
            }
          },
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {
            deleteNote(context, note);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {
            saveNote(context,
                title: titleController.text,
                content: contentController.text,
                note: note);
          },
          icon: const Icon(Icons.save),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            saveNote(context,
                title: titleController.text,
                content: contentController.text,
                note: note);
            if (titleController.text == note.name &&
                contentController.text == note.getContent() &&
                note.name.isNotEmpty) {
              Share.share("${titleController.text}\n${contentController.text}");
            }
          },
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {
            saveNote(context,
                title: titleController.text,
                content: contentController.text,
                note: note);
          },
          icon: const Icon(Icons.save),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = note.name;
    contentController.text = note.getContent();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (titleController.text == note.name &&
                  contentController.text == note.getContent()) {
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                        "Do you want to save changes to your note??"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            saveNote(context,
                                title: titleController.text,
                                content: contentController.text,
                                note: note);
                            if (titleController.text == note.name &&
                                contentController.text == note.getContent()) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Save")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Don't Save")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                    ],
                  ),
                );
              }
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        actions: [
          Consumer<NoteProvider>(
            builder: (context, value, child) {
              return Row(
                children: buildActions(note, context),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(fontSize: 32),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.all(8),
                hintText: "Title",
                hintStyle: TextStyle(
                  fontSize: 32,
                  color: Colors.white60,
                ),
              ),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                textAlignVertical: TextAlignVertical.top,
                minLines: null,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  hintText: "Write Stuff here...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
