import 'package:flutter/material.dart';
import 'package:note_taker/interface/notes/add_note.dart';
import 'package:note_taker/interface/notes/note_model.dart';
import 'package:note_taker/storage/database/database.dart';
import 'package:note_taker/storage/model/note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<List<Note>>(
          stream: databaseHelper.watchNotes(), // Use the notes stream
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading spinner while the stream is waiting for data
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Display error message if there is an error in the stream
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // Show a message when there are no notes available
              return const Center(child: Text('No notes available'));
            } else {
              // Display the list of notes
              final notes = snapshot.data!;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteModel(note: note);
                },
              );
            }
          },
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddNote()));
            },
            tooltip: 'Add Note',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
