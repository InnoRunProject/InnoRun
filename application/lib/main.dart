import 'package:flutter/material.dart';
import 'package:innorun/pages/runOwerview.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/pages/main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CreatedSessions(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(ThemeData.light()),
        ),
      ],
      child: const InnoRun(),
    )
  );
}


class InnoRun extends StatelessWidget {
  const InnoRun({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InnoRun',
          theme: notifier.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePageForState(),
            '/map': (context) => const MapScreenn(),
          },
        );
      }
    );
  }
}