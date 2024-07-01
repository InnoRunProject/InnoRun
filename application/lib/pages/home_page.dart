import 'package:flutter/material.dart';
import 'package:innorun/data/boxes.dart';
import 'package:innorun/data/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageForState();
}

class HomePageForState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: boxSessions.length,
                      itemBuilder: (context, index) {
                        Session session = boxSessions.getAt(index);
                        return ListTile(
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                boxSessions.deleteAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          title: Text(session.description),
                          subtitle: const Text('Description'),
                          trailing: Text('Time: ${session.time}'),
                        );
                      },
                    )
                  )
                )
              )
            )
          ],
        )
    );
  }

}