import 'package:flutter/material.dart';
import 'package:noted/models/note_model.dart';
import 'package:noted/pages/note_edit_page.dart';
import 'package:noted/utils/note_actions.dart';
import 'package:noted/utils/providers/note_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/note_widget.dart';

class HomePage extends StatelessWidget {
  final String userName;
  HomePage({super.key, required this.userName});

  final TextEditingController searchController = TextEditingController()
    ..text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrolledUnderElevation: 0,
        title: Consumer<NoteProvider>(
          builder: (context, value, child) {
            if (value.getNotes().any((note) => note.isSelected)) {
              return Text(
                  "${value.getNotes().where((note) => note.isSelected).length} Selected");
            }
            return Text("Hello $userName");
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                context.read<NoteProvider>().setNotesAfterSearch(query);
              },
              focusNode: FocusNode(canRequestFocus: false),
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(26, 31, 40, 1),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.white60,
                ),
                hintText: "Search for a note",
                hintStyle: const TextStyle(color: Colors.white60),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        actions: [
          Consumer<NoteProvider>(
            builder: (context, value, child) {
              if (value.getNotes().any((note) => note.isSelected)) {
                return IconButton(
                  onPressed: () {
                    List<Note> notes = value
                        .getNotes()
                        .where((note) => note.isSelected)
                        .toList();
                    deleteNotes(context, notes);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(62, 123, 202, 1.0),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteEditPage(
              note: Note(name: ""),
            ),
          ));
        },
        child: const Icon(Icons.add),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notes",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Consumer<NoteProvider>(
                builder: (context, value, child) => Text(
                  "${value.getNotesAfterSearch().length} notes",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white30,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder(
                future: context.read<NoteProvider>().loadNotes(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                            ),
                            const Center(child: CircularProgressIndicator()),
                          ],
                        )
                      : Consumer<NoteProvider>(
                          builder: (context, value, child) {
                            if (value.getNotes().isNotEmpty) {
                              if (value.getNotesAfterSearch().isNotEmpty) {
                                return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    childAspectRatio: 0.65,
                                    maxCrossAxisExtent: 250,
                                  ),
                                  itemCount: value.getNotesAfterSearch().length,
                                  itemBuilder: (context, index) {
                                    return NoteWidget(
                                        note:
                                            value.getNotesAfterSearch()[index]);
                                  },
                                );
                              } else {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                    ),
                                    const Center(
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          "You have no notes with this name\nTry another search"),
                                    ),
                                  ],
                                );
                              }
                            } else {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                                  const Center(
                                    child: Text(
                                        textAlign: TextAlign.center,
                                        "You have no notes\nTap the '+' button to add a new note"),
                                  ),
                                ],
                              );
                            }
                          },
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
