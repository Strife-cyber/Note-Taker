import 'package:flutter/material.dart';
import 'package:note_taker/storage/database/database.dart';
import 'package:note_taker/storage/model/note.dart';

class UpdateNote extends StatefulWidget {
  final Note note; // Pass the note to be updated

  const UpdateNote({super.key, required this.note});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _categoryController;
  late TextEditingController _tagsController;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the note's data
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _categoryController = TextEditingController(text: widget.note.category);
    _tagsController = TextEditingController(text: widget.note.tags.join(', '));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _updateNote() {
    final String title = _titleController.text;
    final String content = _contentController.text;
    final String category = _categoryController.text;
    final List<String> tags =
        _tagsController.text.split(',').map((tag) => tag.trim()).toList();
    final DateTime now = DateTime.now();

    // Here you can handle updating the note, e.g., saving it to a list or sending it to a backend.
    // For example, you could print the updated note data or show a confirmation dialog.

    databaseHelper.updateNote(
        widget.note.title,
        Note(
            title: title,
            content: content,
            category: category,
            tags: tags,
            createdAt: widget.note.createdAt,
            lastUpdated: now));

    // Optionally, you could navigate back or show a confirmation dialog
    Navigator.pop(context); // Navigate back after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Note'),
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
              onPressed: _updateNote,
              child: const Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
