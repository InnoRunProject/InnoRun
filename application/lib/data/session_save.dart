import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';

part 'session_save.g.dart';

@HiveType(typeId: 0)
class SessionSave {
  SessionSave({required this.name, required this.time, required this.place, required this.latlng});

  @HiveField(0)
  String name;

  @HiveField(1)
  String time;

  @HiveField(2)
  String place;

  @HiveField(3)
  List<LatLng> latlng;
}