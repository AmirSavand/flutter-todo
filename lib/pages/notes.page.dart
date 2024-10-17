import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:go_router/go_router.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> _notes = [];

  final TextEditingController _taskInputController = TextEditingController();

  void _setup() {
    Note.store.items.then((List<Note> value) {
      setState(() {
        _notes = value;
      });
    });
  }

  void _unFocusInput() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    _setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 8)),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(note.shortContent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    onTap: () async {
                      await context.push('/note/${note.id}');
                      _setup();
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              minLines: 2,
              maxLines: 5,
              controller: _taskInputController,
              onTapOutside: (_) => _unFocusInput(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Write a note',
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    onPressed: () {
                      final String text = _taskInputController.text;
                      _taskInputController.clear();
                      _unFocusInput();
                      setState(() {
                        Note newNote = Note.create(content: text);
                        Note.store.add(newNote);
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
