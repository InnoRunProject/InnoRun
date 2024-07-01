import 'package:flutter/material.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/pages/main_page.dart';
import 'package:innorun/pages/map.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:innorun/data/locale_provider.dart';

void main() {
  runApp(MultiProvider(
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
      ChangeNotifierProvider(
        create: (_) => LocaleProvider(),
      )
    ],
    child: const InnoRun(),
  ));
}

class InnoRun extends StatelessWidget {
  const InnoRun({super.key});
  static Locale locale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InnoRun',
        theme: notifier.currentTheme,
        initialRoute: '/',
        locale: Provider.of<LocaleProvider>(context).locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
        routes: {
          '/': (context) => const HomePageForState(),
          '/map': (context) => const MapScreen(),
        },
      );
    });
  }
}
