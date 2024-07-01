import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/pages/main_page.dart';
import 'package:innorun/pages/map.dart';
import 'package:innorun/data/boxes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SessionAdapter());
  boxSessions = await Hive.openBox<Session>('sessionBox');
  boxPreviousSessions = await Hive.openBox<Session>('previousSessionBox');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CreatedSessions(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(ThemeData.light()),
        ),
        ChangeNotifierProvider(
          create: (_) => CreatedSessionsHistory(),
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
            '/map': (context) => const MapScreen(),
          },
        );
      }
    );
  }
}