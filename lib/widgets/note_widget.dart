import 'package:flutter/material.dart';
import 'package:noted/pages/note_edit_page.dart';
import 'package:noted/utils/providers/note_provider.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';

class NoteWidget extends StatelessWidget {
  final Note note;

  const NoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, value, child) {
        if (!value.getNotes().any((note) => note.isSelected)) {
          return NotSelected(note: note);
        } else if (value.getNotes().any((note) => note.isSelected) &&
            !note.isSelected) {
          return OneSelected(note: note);
        } else {
          return Selected(note: note);
        }
      },
    );
  }
}

class NotSelected extends StatelessWidget {
  const NotSelected({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditPage(note: note),
              ));
        },
        onLongPress: () {
          context.read<NoteProvider>().toggleSelection(note);
        },
        child: Ink(
          width: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(62, 123, 202, 1.0).withOpacity(0.1),
                blurRadius: 10,
                //offset: Offset(-3, -3),
              ),
            ],
            color: const Color.fromRGBO(28, 31, 39, 1.0).withOpacity(.7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.name,
                  softwrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.elipsis,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  note.getContent().isEmpty
                      ? "Write stuff here..."
                      : note.getContent(),
                  softWrap: true,
                  maxLines: 9,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Text(
                      "${note.getLastModifiedTime().year}-${note.getLastModifiedTime().month}-${note.getLastModifiedTime().day}",
                      style: const TextStyle(
                        color: Colors.white30,
                        fontSize: 13,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      "${note.getLastModifiedTime().hour}:${note.getLastModifiedTime().minute}",
                      style: const TextStyle(
                        color: Colors.white30,
                        fontSize: 13,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OneSelected extends StatelessWidget {
  const OneSelected({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(83, 83, 83, 1.0),
              ),
            ),
          ),
          Ink(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.7),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              context.read<NoteProvider>().toggleSelection(note);
            },
            child: Ink(
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(62, 123, 202, 1.0)
                        .withOpacity(0.1),
                    blurRadius: 10,
                    //offset: Offset(-3, -3),
                  ),
                ],
                color: const Color.fromRGBO(28, 31, 39, 1.0).withOpacity(.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.name,
                         softwrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.elipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      note.getContent().isEmpty
                          ? "Write stuff here..."
                          : note.getContent(),
                      softWrap: true,
                      maxLines: 9,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white60,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Text(
                          "${note.getLastModifiedTime().year}-${note.getLastModifiedTime().month}-${note.getLastModifiedTime().day}",
                          style: const TextStyle(
                            color: Colors.white30,
                            fontSize: 13,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          "${note.getLastModifiedTime().hour}:${note.getLastModifiedTime().minute}",
                          style: const TextStyle(
                            color: Colors.white30,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Selected extends StatelessWidget {
  const Selected({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
          ),
          Ink(
            width: 200,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.7),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              context.read<NoteProvider>().toggleSelection(note);
            },
            child: Ink(
              width: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(62, 123, 202, 1.0)
                        .withOpacity(0.1),
                    blurRadius: 10,
                    //offset: Offset(-3, -3),
                  ),
                ],
                color: const Color.fromRGBO(28, 31, 39, 1.0).withOpacity(.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.name,
                         softwrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.elipsis,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      note.getContent().isEmpty
                          ? "Write stuff here..."
                          : note.getContent(),
                      softWrap: true,
                      maxLines: 9,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white60,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    Row(
                      children: [
                        Text(
                          "${note.getLastModifiedTime().year}-${note.getLastModifiedTime().month}-${note.getLastModifiedTime().day}",
                          style: const TextStyle(
                            color: Colors.white30,
                            fontSize: 13,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          "${note.getLastModifiedTime().hour}:${note.getLastModifiedTime().minute}",
                          style: const TextStyle(
                            color: Colors.white30,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
