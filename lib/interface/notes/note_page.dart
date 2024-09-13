import 'package:flutter/material.dart';
import 'package:note_taker/storage/model/note.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: Text(note.title,
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Category: ${note.category}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis)),
                Text(
                    note.tags.isNotEmpty
                        ? "Tags: None"
                        : "Tags: ${note.tags.join(', ')}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(note.content,
                  style: const TextStyle(color: Colors.black87, fontSize: 18),
                  textAlign: TextAlign.center),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Created: ${note.toDate(note.createdAt)}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis)),
                Text("Updated: ${note.toDate(note.lastUpdated)}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// To use this in your NoteModel or elsewhere
void showNoteDetails(BuildContext context, Note note) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SizedBox(
        height: 400,
        child: NotePage(note: note),
      );
    },
  );
}
