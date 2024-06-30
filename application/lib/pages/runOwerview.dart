import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../data/provider.dart';
import 'package:innorun/pages/main_page.dart';


class MapScreenn extends StatefulWidget {
  final int index;
  MapScreenn({required this.index, Key? key}) : super(key: key);

  @override
  State<MapScreenn> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenn> {
  late final MapController _mapController;
  double zoom = 15.0;

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
  @override
  Widget build(BuildContext context) {
    CreatedSessions createdSessions = Provider.of<CreatedSessions>(context, listen: false);
    List<Session> sessions = createdSessions.sessions;
    String name = sessions[widget.index].name;
    String time = sessions[widget.index].time;
    String place = sessions[widget.index].place;
    List<LatLng> _points = sessions[widget.index].latlng;
    List<Marker> _markers2 = [];
    for(int i = 0; i < _points.length; i++){
      _markers2.add(Marker(
          point: _points[i],
          child: _markers2.isEmpty? const Icon(Icons.pin_drop, color: Colors.black) :
          const Icon(Icons.run_circle_rounded, color: Colors.black)
      ));
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(55.753141, 48.742795),
                      initialZoom: zoom,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.flutter_map_example',
                      ),
                      MarkerLayer(
                        markers: _markers2,
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: _points,
                            color: Colors.red,
                            strokeWidth: 5,
                          ),
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
                icon: Icon(Icons.zoom_out),
              ),
              IconButton(
                onPressed: () {
                  if (zoom < 19) {
                    setState(() {
                      zoom++;
                    });
                  }
                  _mapController.move(LatLng(55.753141, 48.742795), zoom);
                },
                icon: Icon(Icons.zoom_in),
              ),
            ],
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name of creator: $name"),
                  SizedBox(height: 8.0),
                  Text("Place:  $place"),
                  SizedBox(height: 8.0),
                  Text("Time: $time"),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePageForState()),
                          );
                          print("Кнопка создать нажата");
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('Join'),
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