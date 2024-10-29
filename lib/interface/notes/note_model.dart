import 'package:flutter/material.dart';
import 'package:note_taker/interface/notes/note_page.dart';
import 'package:note_taker/interface/notes/update_note.dart';
import 'package:note_taker/storage/database/database.dart';
import 'package:note_taker/storage/model/note.dart';

class NoteModel extends StatelessWidget {
  final Note note;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  NoteModel({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showNoteDetails(context, note);
      },
      onLongPress: () {
        _showContextMenu(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: 400,
          height: 110,
          color: Colors.grey[400],
          child: Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        note.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Montaga',
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category: ${note.category}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Pacifico'),
                        ),
                        Text(
                          note.tags != []
                              ? "Tags: ${note.tags.join(',')}"
                              : "Tags: None",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Pacifico'),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
                      child: Text(
                        note.content,
                        maxLines: 3,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Pacifico'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Created: ${note.toDate(note.createdAt)}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Pacifico'),
                        ),
                        Text(
                          "Updated: ${note.toDate(note.lastUpdated)}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Pacifico'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(
                'Update',
                style: TextStyle(fontFamily: 'Pacifico'),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement the update functionality here
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateNote(note: note)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text(
                'Delete',
                style: TextStyle(fontFamily: 'Pacifico'),
              ),
              onTap: () {
                Navigator.pop(context);
                // Implement the delete functionality here
                databaseHelper.deleteNote(note.title);
              },
            ),
          ],
        );
      },
    );
  }
}
