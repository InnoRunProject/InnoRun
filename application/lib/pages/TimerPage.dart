import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:innorun/pages/animatedHeart.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../data/provider.dart';
import 'main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class StopwatchPage extends StatefulWidget {
  final int index;

  StopwatchPage({required this.index, Key? key}) : super(key: key);

  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  bool isRunning = false;
  int seconds = 0;
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

  void startWatch() {
    Future.delayed(const Duration(seconds: 1), () {
      if (isRunning) {
        setState(() {
          seconds++;
        });
        startWatch();
      }
    });
  }

  void onPauseButtonPressed() {
    setState(() {
      isRunning = false;
    });
  }

  void onContinueButtonPressed() {
    setState(() {
      isRunning = true;
      startWatch();
    });
  }

  @override
  Widget build(BuildContext context) {
    CreatedSessions createdSessions =
        Provider.of<CreatedSessions>(context, listen: false);
    CreatedSessionsHistory createdSessionsHistory =
        Provider.of<CreatedSessionsHistory>(context, listen: false);
    List<Session> sessions = createdSessions.sessions;
    List<LatLng> _points = sessions[widget.index].latlng;
    List<Marker> _markers2 = [];
    String name = sessions[widget.index].name;
    String time = sessions[widget.index].time;
    String place = sessions[widget.index].place;
    for (int i = 0; i < _points.length; i++) {
      _markers2.add(Marker(
          point: _points[i],
          child: _markers2.isEmpty
              ? const Icon(Icons.pin_drop, color: Colors.black)
              : const Icon(Icons.run_circle_rounded, color: Colors.black)));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('InnoRun'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HeartBeatAnimation(
              isRunning: true,
            ),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  seconds.toString(),
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 20),
            isRunning
                ? ElevatedButton(
                    onPressed: onPauseButtonPressed,
                    child: Text(AppLocalizations.of(context)!.pause),
                  )
                : ElevatedButton(
                    onPressed: onContinueButtonPressed,
                    child: Text(AppLocalizations.of(context)!.continuee),
                  ),
            ElevatedButton(
                onPressed: () {
                  createdSessionsHistory.addSession(
                      name, time, place, _points, seconds.toString());
                  createdSessions.removeSession(widget.index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePageForState()),
                  );
                },
                child: Text(AppLocalizations.of(context)!.finish))
          ],
        ),
      ),
    );
  }
}
