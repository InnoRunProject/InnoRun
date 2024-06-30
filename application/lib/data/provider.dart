import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class CreatedSessions extends ChangeNotifier {
  List<Session> _sessions = [];
  List<Session> get sessions => _sessions;
  void addSession(String name, String time, String place,List<LatLng> latlng ) {
    _sessions.insert(0, Session(name: name, time: time, place: place, latlng: latlng));
    notifyListeners();
  }
}

class Session {
  final String name;
  final String time;
  final String place;
  final List<LatLng> latlng;
  Session({required this.name, required this.time, required this.place, required this.latlng});
  @override
  String toString() {
    return "time: $time, creator: $name, place: $place";
  }
}