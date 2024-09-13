import 'package:flutter/material.dart';
import 'package:note_taker/interface/screen/base_screen.dart';
import 'package:note_taker/interface/screen/theme.dart';
import 'package:note_taker/storage/database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the Sembast database before running the app
  await initializeDatabase();

  runApp(const MyApp());
}

Future<void> initializeDatabase() async {
  DatabaseHelper databaseHelper = DatabaseHelper();
  await databaseHelper.getNotes();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Using a ValueNotifier to manage the current theme
  final ValueNotifier<AppTheme> _themeNotifier = ValueNotifier(AppTheme.light);

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  // Function to toggle the theme
  void _toggleTheme() {
    // Toggle between light and dark themes
    _themeNotifier.value =
        _themeNotifier.value == AppTheme.light ? AppTheme.dark : AppTheme.light;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppTheme>(
      valueListenable: _themeNotifier,
      builder: (context, currentTheme, _) {
        // Create an instance of Themes with the current theme value
        final themes = Themes(appTheme: currentTheme);
        return MaterialApp(
          theme: themes.getTheme(),
          home: BaseScreen(
            onToggleTheme: _toggleTheme,
            isDarkMode: currentTheme == AppTheme.dark,
          ),
        );
      },
    );
  }
}
