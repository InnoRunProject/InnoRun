import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/pages/main_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:innorun/data/session_save.dart';

import 'data/boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SessionSaveAdapter());
  boxSession = await Hive.openBox<SessionSave>('sesssionsBox');
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
          home: const HomePageForState(),
        );
      }
    );
  }
}