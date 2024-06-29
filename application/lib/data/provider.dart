import 'package:flutter/material.dart';

class CreatedSessions extends ChangeNotifier {
  List<Session> _sessions = [];
  List<Session> get sessions => _sessions;
  void addSession(String name, String time, String place) {
    _sessions.insert(0, Session(name: name, time: time, place: place));
    notifyListeners();
  }
}

class Session {
  final String name;
  final String time;
  final String place;
  Session({required this.name, required this.time, required this.place});
}