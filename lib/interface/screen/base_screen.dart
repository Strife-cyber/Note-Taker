import 'package:flutter/material.dart';
import 'package:note_taker/interface/notes/note_screen.dart';

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
        title: const Text('Nexus Note Taker'),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.brightness_7 : Icons.brightness_4),
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
