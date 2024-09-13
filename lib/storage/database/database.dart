import 'package:flutter/foundation.dart';
import 'package:note_taker/storage/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance =
      DatabaseHelper._internal(); // Singleton instance
  static Database? _database;
  final _store =
      intMapStoreFactory.store('notes'); // Store for the 'notes' collection

  // Private constructor
  DatabaseHelper._internal();

  // Factory constructor to return the singleton instance
  factory DatabaseHelper() {
    return _instance;
  }

  // Method to get the database instance
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      return databaseFactoryWeb.openDatabase('notes.db');
    } else {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = join(dir.path, 'notes.db');
      return databaseFactoryIo.openDatabase(dbPath);
    }
  }

  // Add a new note
  Future<void> addNote(Note note) async {
    final db = await database; // Ensure database is initialized
    await _store.add(db, note.toMap());
  }

  // Retrieve all notes
  Future<List<Note>> getNotes() async {
    final db = await database;
    final records = await _store.find(db);
    return records.map((record) => Note.fromMap(record.value)).toList();
  }

  // Update an existing note by title
  Future<void> updateNote(String title, Note newNote) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('title', title));
    await _store.update(db, newNote.toMap(), finder: finder);
  }

  // Delete a note by title
  Future<void> deleteNote(String title) async {
    final db = await database;
    final finder = Finder(filter: Filter.equals('title', title));
    await _store.delete(db, finder: finder);
  }

  // Add a method to get the notes stream
  Stream<List<Note>> watchNotes() {
    try {
      final finder = Finder(sortOrders: [SortOrder(Field.key)]);
      final query = _store.query(finder: finder);
      return query.onSnapshots(_database!).map((snapshots) {
        // Safely handle cases where snapshots or snapshot values might be null
        if (snapshots.isEmpty) {
          addNote(Note(
              title: 'Sample Note',
              content: 'This is a sample note',
              category: 'Default',
              tags: [],
              createdAt: DateTime.now(),
              lastUpdated: DateTime.now()));
          return <Note>[]; // Return an empty list if no snapshots are available
        }
        return snapshots
            .map((snapshot) =>
                Note.fromMap(snapshot.value)) // Use `!` safely after filtering
            .toList();
      });
    } catch (e) {
      // Handle any errors that might occur during the query or mapping
      return const Stream<
          List<Note>>.empty(); // Return an error stream if an exception occurs
    }
  }
}
