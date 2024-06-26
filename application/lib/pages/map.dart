import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../data/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void convertToJson(
    List<LatLng> _latlng, String name, String time, String place) {
  String pointsJson =
      jsonEncode(_latlng.map((point) => point.toJson()).toList());
  var event = {
    'date': time,
    'owner': name,
    'route': pointsJson,
  };
  String jsonEvent = jsonEncode(event);
  // print(pointsJson);
  convertFromJson(jsonEvent);
}

Session convertFromJson(String jsonString) {
  Map<String, dynamic> jsonData = jsonDecode(jsonString);
  String name = jsonData['owner'];
  String time = jsonData['date'];
  String place = jsonData['place'];
  List<dynamic> pointsJson = jsonDecode(jsonData['route']);
  List<LatLng> latlng =
      pointsJson.map((point) => LatLng.fromJson(point)).toList();

  print('Name: $name');
  print('Time: $time');
  print('LatLng: ${latlng}');
  return Session(name: name, time: time, place: place, latlng: latlng);
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;
  double zoom = 15.0;
  final nameController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();
  List<Marker> _markers = [];
  List<LatLng> _points = [];

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void addMarker(LatLng lat) {
    setState(() {
      _points.add(lat);
      _markers.add(Marker(
          point: lat,
          child: _markers.isEmpty
              ? const Icon(Icons.pin_drop, color: Colors.black)
              : const Icon(Icons.run_circle_rounded, color: Colors.black)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 30, 50, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                        initialCenter: LatLng(55.753141, 48.742795),
                        initialZoom: zoom,
                        onTap: (tapPosition, point) {
                          addMarker(point);
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.flutter_map_example',
                      ),
                      MarkerLayer(markers: _markers),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                              points: _points,
                              color: Colors.red,
                              strokeWidth: 5),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    if (zoom > 5) {
                      setState(() {
                        zoom--;
                      });
                    }
                    _mapController.move(LatLng(55.753141, 48.742795), zoom);
                  },
                  icon: Icon(Icons.zoom_out)),
              IconButton(
                  onPressed: () {
                    if (zoom < 19) {
                      setState(() {
                        zoom++;
                      });
                    }
                    _mapController.move(LatLng(55.753141, 48.742795), zoom);
                  },
                  icon: Icon(Icons.zoom_in)),
              IconButton(
                  onPressed: () {
                    if (_markers.isNotEmpty) {
                      setState(() {
                        _markers.removeLast();
                        _points.removeLast();
                      });
                    }
                  },
                  icon: Icon(Icons.arrow_back))
            ],
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.name,
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: placeController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.place,
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      controller: timeController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.time,
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print("Кнопка создать нажата");
                          String name = nameController.text;
                          String time = timeController.text;
                          String place = placeController.text;
                          // convertToJson(_points, name, time, place);
                          Provider.of<CreatedSessions>(context, listen: false)
                              .addSession(name, time, place, _points);
                          Navigator.pushNamed(context, '/');
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.black),
                          foregroundColor:
                              WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(AppLocalizations.of(context)!.create),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
