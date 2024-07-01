import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/pages/runOwerview.dart';

class HomePageInitial extends StatelessWidget {
  const HomePageInitial({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color buttonColor = theme.brightness == Brightness.light ? Colors.black : Colors.white;
    Color TextColor = theme.brightness == Brightness.light ? Colors.white : Colors.black;
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount:
                  Provider.of<CreatedSessions>(context).sessions.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child:ElevatedButton(
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
                          builder: (context) => MapScreenn(index: index),
                        ),
                      );
                    },
                    child: Text(
                      Provider.of<CreatedSessions>(context).sessions[index].toString(),
                      style: TextStyle(color: TextColor),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}