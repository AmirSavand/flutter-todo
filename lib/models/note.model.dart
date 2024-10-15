import 'package:uuid/uuid.dart';

import '../classes/store.dart';

/// A class representing a Note.
class Note {
  /// Store instance to manage notes.
  static final store = Store<Note>(
    key: 'notes',
    toJson: (Note item) => item.toJson(),
    fromJson: (Map<String, dynamic> item) => Note.fromJson(item),
  );

  /// UUID instance reference.
  static const _uuid = Uuid();

  /// Unique ID of the note, generated using UUID v4.
  final String id;

  /// The date and time when the note was created.
  final DateTime created;

  /// The content or name of the note.
  String content;

  Note._({
    required this.id,
    required this.content,
    required this.created,
  });

  /// Convert a Note object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'created': created.toIso8601String(),
    };
  }

  /// Create a Note object from a JSON map.
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note._(
      id: json['id'],
      content: json['content'],
      created: DateTime.parse(json['created']),
    );
  }

  static create({required String content}) {
    return Note._(
      id: _uuid.v4(),
      content: content,
      created: DateTime.now(),
    );
  }
}
