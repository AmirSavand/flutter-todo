import 'package:uuid/uuid.dart';

/// A class representing a Note.
class Note {
  /// Unique ID of the note, generated using UUID v4.
  final String id = (const Uuid()).v4();

  /// The date and time when the note was created.
  final DateTime created = DateTime.now();

  /// The content or name of the note.
  String content;

  Note({
    required this.content,
  });
}
