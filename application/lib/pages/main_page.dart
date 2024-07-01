import 'package:flutter/material.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/pages/map.dart';
import 'package:provider/provider.dart';
import 'package:innorun/pages/home_page.dart';
import 'HistoryPage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:innorun/data/locale_provider.dart';

class HomePageForState extends StatefulWidget {
  const HomePageForState({super.key});

  @override
  State<HomePageForState> createState() => HomePage();
}

class HomePage extends State<HomePageForState> {
  bool ddd = false;
  int currentIndex = 0;
  List<Widget> body = const [
    HomePageInitial(),
    Historypage(),
    MapScreen(),
  ];
  Color navigationBarIconColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InnoRun'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeNotifier>(context, listen: false).switchTheme();
              setState(() {
                navigationBarIconColor = Colors.black == navigationBarIconColor
                    ? Colors.red
                    : Colors.black;
                AppLocalizations.supportedLocales;
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') {
                Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('en'));
              } else if (value == 'ru') {
                Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('ru'));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'en',
                  child: Text('Endglish'),
                ),
                const PopupMenuItem(
                  value: 'ru',
                  child: Text('Русский'),
                ),
              ];
            },
          )
        ],
      ),
      body: body[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: navigationBarIconColor,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: AppLocalizations.of(context)!.history),
          BottomNavigationBarItem(icon: Icon(Icons.wifi_tethering), label: AppLocalizations.of(context)!.addSession),
        ],
      ),
    );
  }
}
