import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/provider.dart';
import 'HistoryPageOne.dart';

class Historypage extends StatefulWidget {
  const Historypage({super.key});

  @override
  State<Historypage> createState() => _HistorypageState();
}

class _HistorypageState extends State<Historypage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color buttonColor = theme.brightness == Brightness.light ? Colors.black : Colors.white;
    Color TextColor = theme.brightness == Brightness.light ? Colors.white : Colors.black;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: Provider.of<CreatedSessionsHistory>(context)
                      .sessions
                      .length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(buttonColor),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Historypageone(index: index)),
                          );
                        },
                        child: Text(
                          Provider.of<CreatedSessionsHistory>(context)
                              .sessions[index]
                              .toString(),
                          style: TextStyle(color: TextColor),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
