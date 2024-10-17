import 'package:flutter/material.dart';
import 'package:flutter_todo/classes/classes.dart';
import 'package:go_router/go_router.dart';

class WrapperPage extends StatefulWidget {
  final Widget child;

  const WrapperPage({super.key, required this.child});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _selectedIndex = 1;

  final List<LinkItem> _links = const [
    LinkItem(route: '/notes', icon: Icons.notes, label: 'Notes'),
    LinkItem(route: '/', icon: Icons.task_alt, label: 'Tasks'),
    LinkItem(route: '/settings', icon: Icons.settings, label: 'Settings'),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_links[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: _links
            .map((item) => NavigationDestination(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}
