import 'package:flutter/material.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/pages/map.dart';
import 'package:provider/provider.dart';
import 'package:innorun/pages/home_page.dart';
import 'HistoryPage.dart';

class HomePageForState extends StatefulWidget {
  const HomePageForState({super.key});

  @override
  State<HomePageForState> createState() => HomePage();
}

class HomePage extends State<HomePageForState> {
  int currentIndex = 0;
  List<Widget> body = const [
    HomePageInitial(),
    Historypage(),
    MapScreen(),
  ];


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
            },
          ),
        ],
      ),
      body: body[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.wifi_tethering), label: 'Add session'),
        ],
      ),
    );
  }
}
