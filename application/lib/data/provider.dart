import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

part 'provider.g.dart';


class CreatedSessions extends ChangeNotifier {
  List<Session> _sessions = []; 
  List<Session> get sessions => _sessions;

  void addSession(String description, String time, String place,List<LatLng> latlng ) {
    _sessions.insert(0, Session(description: description, time: time, place: place, latlng: latlng));
    notifyListeners();
  }
  void removeSession(int index) {
    if (index >= 0 && index < _sessions.length) {
      _sessions.removeAt(index);
      notifyListeners();
    }
  }
}


@HiveType(typeId: 0)
class Session {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final String time;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final List<LatLng> latlng;
  Session({required this.description, required this.time, required this.place, required this.latlng});
  @override
  String toString() {
    return "Time: $time, Creator: $description, Place: $place";
  }
}

class CreatedSessionsHistory extends ChangeNotifier {
  List<SessionHistory> _sessions = [];
  List<SessionHistory> get sessions => _sessions;
  void addSession(String name, String time, String place,List<LatLng> latlng, String RunTime) {
    _sessions.insert(0, SessionHistory(name: name, time: time, place: place, latlng: latlng, RunTime: RunTime));
    notifyListeners();
  }
  void removeSession(int index) {
    if (index >= 0 && index < _sessions.length) {
      _sessions.removeAt(index);
      notifyListeners();
    }
  }
}

class SessionHistory {
  final String name;
  final String time;
  final String place;
  final List<LatLng> latlng;
  final String RunTime;
  SessionHistory({required this.name, required this.time, required this.place, required this.latlng, required this.RunTime});
  @override
  String toString() {
    return "time: $time, creator: $name, place: $place, RunTime: $RunTime";
  }
}