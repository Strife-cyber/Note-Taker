import 'package:flutter/material.dart';
import 'package:note_taker/storage/database/database.dart';
import 'package:note_taker/storage/model/note.dart';

import 'note_model.dart';

class SearchNotesPage extends StatefulWidget {
  const SearchNotesPage({super.key});

  @override
  State<SearchNotesPage> createState() => _SearchNotesPageState();
}

class _SearchNotesPageState extends State<SearchNotesPage> {
  String searchQuery = '';
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Search Notes', style: TextStyle(fontFamily: 'Montaga')),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style:
                  const TextStyle(fontFamily: 'Pacifico', color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Search notes',
                labelStyle: TextStyle(
                  fontFamily: 'Pacifico', // Font family for the label text
                  color: Colors.black, // Color for the label text
                  fontSize: 16, // Optional: adjust font size if needed
                ),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // Notes List using StreamBuilder
          Expanded(
            child: StreamBuilder<List<Note>>(
              stream: databaseHelper.watchNotes(), // Use the notes stream
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No notes available'));
                } else {
                  final notes = snapshot.data!.where((note) {
                    // Filter notes based on title, category, or tags
                    return note.title
                            .trim()
                            .toLowerCase()
                            .contains(searchQuery) ||
                        note.category
                            .trim()
                            .toLowerCase()
                            .contains(searchQuery) ||
                        note.tags.any(
                            (tag) => tag.toLowerCase().contains(searchQuery));
                  }).toList();

                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return NoteModel(note: note); // Replace with your widget
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
