import 'package:flutter/material.dart';
import 'package:flutter_todo/models/note.model.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [
    Note(
      content: "It was hidden under the log beside the stream. "
          "It had been there for as long as Jerry had been alive. "
          "He wasn't sure if anyone besides him and his friends knew "
          "of its existence.\n\nHe knew that anyone could potentially "
          "find it, but it was well enough hidden that it seemed unlikely "
          "to happen. The fact that it had been there for more than 30 "
          "years attested to this. So it was quite a surprise when he "
          "found the item was missing.",
    ),
    Note(
      content: "It was hidden under the log beside the stream. "
          "It had been there for as long as Jerry had been alive. "
          "He wasn't sure if anyone besides him and his friends knew "
          "of its existence.\n\nHe knew that anyone could potentially "
          "find it, but it was well enough hidden that it seemed unlikely "
          "to happen. The fact that it had been there for more than 30 "
          "years attested to this. So it was quite a surprise when he "
          "found the item was missing.",
    ),
    Note(
      content: "It was hidden under the log beside the stream.\n\n"
          "It had been there for as long as Jerry had been alive. "
          "He wasn't sure if anyone besides him and his friends knew "
          "of its existence. He knew that anyone could potentially "
          "find it, but it was well enough hidden that it seemed unlikely "
          "to happen.\n\n The fact that it had been there for more than 30 "
          "years attested to this. So it was quite a surprise when he "
          "found the item was missing.",
    ),
  ];

  final TextEditingController _taskInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 16)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(note.content),
                          const SizedBox(height: 16),
                          Text(
                            DateFormat.yMd().add_jm().format(note.created),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              minLines: 2,
              maxLines: 5,
              controller: _taskInputController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Write a note',
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    onPressed: () {
                      final String text = _taskInputController.text;
                      _taskInputController.clear();
                      setState(() {
                        _notes.add(Note(content: text));
                      });
                    },
                    icon: const Icon(Icons.check),
                  ),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _taskInputController.dispose();
  }
}
