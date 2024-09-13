import 'package:flutter/material.dart';
import 'package:note_taker/storage/database/database.dart';
import 'package:note_taker/storage/model/note.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final String title =
        _titleController.text.isEmpty ? "New No Title" : _titleController.text;
    final String content = _contentController.text.isEmpty
        ? "No Content"
        : _contentController.text;
    final String category =
        _categoryController.text.isEmpty ? "Default" : _categoryController.text;
    final List<String> tags = _tagsController.text.isEmpty
        ? []
        : _tagsController.text.split(',').map((tag) => tag.trim()).toList();
    final DateTime now = DateTime.now();

    // Here you can handle saving the note, e.g., adding it to a list or sending it to a backend.
    // For example, you could print the note data or show a confirmation dialog.
    databaseHelper.addNote(Note(
        title: title,
        content: content,
        category: category,
        tags: tags,
        createdAt: now,
        lastUpdated: now));

    // Optionally, you could navigate back or show a confirmation dialog
    Navigator.pop(context); // Navigate back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: 6,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags (comma-separated)',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
