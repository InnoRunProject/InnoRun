import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/provider.dart';
import 'package:innorun/pages/runOwerview.dart';

class HomePageInitial extends ConsumerWidget {
  const HomePageInitial({super.key});
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionKey);
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreenn(index: index, ref: ref)),
                    );
                  },
                  child: Text(sessions[index].toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}