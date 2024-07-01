import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/pages/runOwerview.dart';


class HomePageInitial extends StatelessWidget {
  const HomePageInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}