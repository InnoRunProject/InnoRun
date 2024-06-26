import 'package:flutter/material.dart';
import 'package:innorun/data/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InnoRun'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).swithcTheme();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('InnoRun'),
      ),
    );
  }
}