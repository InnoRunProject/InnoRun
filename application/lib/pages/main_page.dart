import 'package:flutter/material.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/data/theme.dart';
import 'package:innorun/pages/map.dart';
import 'package:innorun/pages/runOwerview.dart';
import 'package:provider/provider.dart';

import 'HistoryPage.dart';

class HomePageForState extends StatefulWidget {
  const HomePageForState({super.key});

  @override
  State<HomePageForState> createState() => HomePage();
}

class HomePage extends State<HomePageForState> {
  bool ddd = false;
  int currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home_outlined),
    Historypage(),
    MapScreen(),
    Icon(Icons.book_outlined),
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
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount:
                    Provider.of<CreatedSessions>(context).sessions.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreenn(index: index)),
                      );
                    },
                    child: Text(Provider.of<CreatedSessions>(context)
                        .sessions[index]
                        .toString()),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: navigationBarIconColor,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (currentIndex == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapScreen()),
              );
            }
            if (currentIndex == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Historypage()),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wifi_tethering), label: 'Add session'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Session'),
        ],
      ),
    );
  }
}
