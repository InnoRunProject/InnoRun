import 'package:dio/dio.dart';
import 'package:innorun/pages/map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageProvider = Provider<StorageSessions>((ref) => StorageSessions());
final sessionKey = StateNotifierProvider<CreatedSessions, List<Session>>((ref) {
  final storage = ref.watch(localStorageProvider);
  return CreatedSessions(storage);
});
final localStorageHistoryProvider = Provider<StorageSessionsHistory>((ref) => StorageSessionsHistory());
final sessionHistoryKey = StateNotifierProvider<CreatedSessionsHistory, List<SessionHistory>>((ref) {
  final storage = ref.watch(localStorageHistoryProvider);
  return CreatedSessionsHistory(storage);
});
class CreatedSessions extends StateNotifier<List<Session>> {
  StorageSessions _storage = StorageSessions();
  CreatedSessions(this._storage) : super([]) {
    _loadStorage();
  }
  void _loadStorage() async {
    state = await _storage._loadSessions();
  }

  void addSession(String name, String time, String place, List<LatLng> latlng) async {
    state.insert(0, Session(name: name, time: time, place: place, latlng: latlng, RunTime: ''));
    await _storage._saveSessions(state);
  }

  void removeSession(int index) async {
    state.removeAt(index);
    await _storage._saveSessions(state);
  }
}
class StorageSessions {
  static const String _key = 'sessions';
  Future<List<Session>> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = prefs.getStringList(_key);
    List<Session>? sessions;
    if (sessionData != null) {
      sessions = sessionData.map((sessionJson) {
        final data = sessionJson.split('|');
        final name = data[0];
        final time = data[1];
        final place = data[2];
        final latlngStr = data[3].split(',');
        final latlng = latlngStr.map((point) => LatLng(
            double.parse(point.split(',')[0]), double.parse(point.split(',')[1]))).toList();
        return Session(
            name: name, time: time, place: place, latlng: latlng, RunTime: '');
      }).toList();
    }
    return sessions ?? [];
  }

  Future<void> _saveSessions(List<Session> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = sessions.map((session) {
      final latlngStr = session.latlng.map((point) => '${point.latitude},${point.longitude}').join(',');
      return "${session.name}|${session.time}|${session.place}|$latlngStr";
    }).toList();
    await prefs.setStringList(_key, sessionData);
  }
}
class Session {
  final String name;
  final String time;
  final String place;
  final List<LatLng> latlng;

  Session(
      {required this.name,
      required this.time,
      required this.place,
      required this.latlng, required String RunTime});

  @override
  String toString() {
    return "time: $time, creator: $name, place: $place";
  }
}

class Parser {
  static String base_url = 'http://localhost:5000/';

  static Future<List<Session>> getSessions() async {
    final response = await Dio().get(base_url);
    List<Session> sessions = [];
    for (var i = 0; i < response.data.length; i++) {
      sessions.add(convertFromJson(response.data[i]));
    }
    return sessions;
  }
}


class CreatedSessionsHistory extends StateNotifier<List<SessionHistory>> {
  StorageSessionsHistory _storage = StorageSessionsHistory();
  CreatedSessionsHistory(this._storage) : super([]) {
    _loadStorage();
  }
  void _loadStorage() async {
    state = await _storage.loadSessions();
  }

  void addSessionHistory(String name, String time, String place, List<LatLng> latlng, String runTime) async {
    state.insert(0, SessionHistory(name: name, time: time, place: place, latlng: latlng, runTime: runTime));
    await _storage.saveSessions(state);
  }

  void removeSessionHistory(int index) async {
    state.removeAt(index);
    await _storage.saveSessions(state);
  }
}

class SessionHistory {
  final String name;
  final String time;
  final String place;
  final List<LatLng> latlng;
  final String runTime;

  SessionHistory(
      {required this.name,
      required this.time,
      required this.place,
      required this.latlng,
      required this.runTime});

  @override
  String toString() {
    return "time: $time, creator: $name, place: $place, RunTime: $runTime";
  }
}

class StorageSessionsHistory {
  static const String _key = 'sessionsHistory';
  Future<List<SessionHistory>> loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = prefs.getStringList(_key);
    List<SessionHistory>? sessions;
    if (sessionData != null) {
      sessions = sessionData.map((sessionJson) {
        final data = sessionJson.split('|');
        final name = data[0];
        final time = data[1];
        final place = data[2];
        final latlngStr = data[3].split(',');
        final latlng = latlngStr.map((point) => LatLng(
            double.parse(point.split(',')[0]), double.parse(point.split(',')[1]))).toList();
            final runTime = data[4];
        return SessionHistory(
            name: name, time: time, place: place, latlng: latlng, runTime: runTime);
      }).toList();
    }
    return sessions ?? [];
  }

  Future<void> saveSessions(List<SessionHistory> sessions) async {
    final prefs = await SharedPreferences.getInstance();
    final sessionData = sessions.map((session) {
      final latlngStr = session.latlng.map((point) => '${point.latitude},${point.longitude}').join(',');
      return "${session.name}|${session.time}|${session.place}|$latlngStr";
    }).toList();
    await prefs.setStringList(_key, sessionData);
  }
}