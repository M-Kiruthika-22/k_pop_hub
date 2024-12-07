import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const SettingsScreen({super.key, required this.toggleTheme});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  void _changeTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      widget.toggleTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: _isDarkMode ? Colors.black : Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: ElevatedButton(
              onPressed: _changeTheme,
              child: const Text("Toggle Theme"),
            ),
          ),
        ),
      ),
    );
  }
}
