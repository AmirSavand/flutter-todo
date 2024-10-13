import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  static const List<String> _pages = [
    '/',
    '/notes',
  ];

  final int selectedIndex;

  const Footer({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.task_alt),
          label: 'Tasks',
        ),
        NavigationDestination(
          icon: Icon(Icons.notes),
          label: 'Notes',
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (int value) {
        Navigator.of(context).pushNamed(Footer._pages[value]);
      },
    );
  }
}
