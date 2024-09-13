import 'dart:convert';

class Note {
  /*
  In future implementations we might add the ability to preview a note
  */
  final String title;
  final String content;
  final String category;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime lastUpdated;

  Note(
      {required this.title,
      required this.content,
      required this.category,
      required this.tags,
      required this.createdAt,
      required this.lastUpdated});

  String toDate(DateTime object) {
    return '${object.year}-${object.month.toString().padLeft(2, '0')}-${object.day.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'tags': tags.join(','),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? '',
      tags: map['tags'].toString().split(','),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(map['lastUpdated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
}
