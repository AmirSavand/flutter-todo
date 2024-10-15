import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WrapperPage extends StatefulWidget {
  final Widget child;

  const WrapperPage({super.key, required this.child});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _selectedIndex = 1;

  final List<_NavigationItem> _navigationItems = const [
    _NavigationItem(
      route: '/notes',
      icon: Icons.notes,
      label: 'Notes',
    ),
    _NavigationItem(
      route: '/',
      icon: Icons.task_alt,
      label: 'Tasks',
    ),
    _NavigationItem(
      route: '/settings',
      icon: Icons.settings,
      label: 'Settings',
    ),
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_navigationItems[index].route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: _navigationItems
            .map((item) => NavigationDestination(
                  icon: Icon(item.icon),
                  label: item.label,
                ))
            .toList(),
      ),
    );
  }
}

// Class to hold navigation item details (route, icon, label)
class _NavigationItem {
  final String route;
  final IconData icon;
  final String label;

  const _NavigationItem({
    required this.route,
    required this.icon,
    required this.label,
  });
}
