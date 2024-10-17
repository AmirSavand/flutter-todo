import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final Uri _homepage = Uri.parse('https://savandbros.com/flutter-todo');

  String _version = 'Loading...';

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        _version = value.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                const ListTile(
                  title: Text('Theme'),
                  subtitle: Text('Sync with OS'),
                ),
                ListTile(
                  title: const Text('App Version'),
                  subtitle: Text(_version),
                ),
                ListTile(
                  title: const Text('About'),
                  subtitle: const Text('Tap for homepage'),
                  onTap: () async {
                    if (await canLaunchUrl(_homepage)) {
                      launchUrl(_homepage);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
