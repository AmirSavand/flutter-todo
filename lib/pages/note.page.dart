import 'package:flutter/material.dart';
import 'package:flutter_todo/models/models.dart';
import 'package:flutter_todo/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key, required this.id});

  final String id;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Note? _note;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    Note.store.items.then((List<Note> notes) {
      try {
        _note = notes.firstWhere((Note item) => item.id == widget.id);
      } catch (error) {
        _note = null;
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: loadingWidget);
    }
    if (_note == null) {
      return Scaffold(body: notFoundWidget(context));
    }
    Note note = _note!;
    return Scaffold(
      body: SingleChildScrollView(
        padding: notificationBarPadding(context),
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(note.content),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Created at ${DateFormat.yMd().add_jm().format(note.created)}',
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    // Remove the note
                    await Note.store.remove(note);
                    setState(() {
                      // Make a snackbar about it
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Your note is now gone'),
                        duration: Duration(seconds: 3),
                      ));
                      // Go back
                      context.pop();
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
