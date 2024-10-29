import 'package:flutter/material.dart';
import 'package:note_taker/interface/notes/note_screen.dart';
import 'package:note_taker/interface/notes/search_note.dart';

class BaseScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const BaseScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchNotesPage()));
            },
            icon: const Icon(Icons.search),
            color: isDarkMode ? Colors.white : Colors.black),
        title: const Text('Nexus Note Taker',
            style: TextStyle(fontFamily: 'Montaga')),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
                color: isDarkMode ? Colors.white : Colors.black),
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: const SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: NoteScreen(),
      )),
    );
  }
}
