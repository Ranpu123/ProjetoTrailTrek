import 'dart:math';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:projeto_dev_disp_mob/pages/record_trail_page.dart';

class SaveLocationPage extends StatefulWidget {
  const SaveLocationPage({Key? key}) : super(key: key);

  @override
  _SaveLocationPageState createState() => _SaveLocationPageState();
}

class _SaveLocationPageState extends State<SaveLocationPage> {
  final Location location = Location();
  List<LocationData> recordedPoints = [];
  bool isRecording = false;
  double totalDistance = 0.0;
  double maxElevation = 0.0;
  DateTime? startTime;

  void startRecording() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isRecording = true;
    });

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (isRecording) {
        setState(() {
          recordedPoints.add(currentLocation);
        });
      }
    });
    setState(() {
      isRecording = true;
      startTime = DateTime.now();
    });
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (isRecording) {
        if (recordedPoints.isNotEmpty) {
          totalDistance += calculateDistanceBetween(
            recordedPoints.last,
            currentLocation,
          );
          maxElevation = max(maxElevation, currentLocation.altitude ?? 0.0);
        }
        setState(() {
          recordedPoints.add(currentLocation);
        });
      }
    });
  }

  void stopRecording() async {
    final duration = DateTime.now().difference(startTime!);
    setState(() {
      isRecording = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecordTrailPage(
          recordedPoints: recordedPoints,
          totalDistance: totalDistance,
          maxElevation: maxElevation,
          duration: duration,
        ),
      ),
    );
  }

  void cancelRecording() {
    setState(() {
      isRecording = false;
      recordedPoints.clear();
    });
    Navigator.pop(context);
  }

  double calculateDistanceBetween(LocationData start, LocationData end) {
    var earthRadius = 6371e3; // Raio da Terra em metros
    var dLat = _toRadians(end.latitude! - start.latitude!);
    var dLon = _toRadians(end.longitude! - start.longitude!);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(start.latitude!)) *
            cos(_toRadians(end.latitude!)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var distance = earthRadius * c;
    return distance; // Retorna a distância em metros
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gravar localização'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isRecording)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.fiber_manual_record, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Gravando...',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Go beyond the horizon',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        height: 0.0,
                      ),
                    ),
                    Text(
                      'Embark on your next adventure with ease '
                      'using our app designed exclusively for adventurers.',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                        height: 0.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: isRecording ? stopRecording : startRecording,
                        child: Text(isRecording ? 'Parar' : 'Começar a gravar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 23, horizontal: 32),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: cancelRecording,
                        child: Text('Cancelar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black26,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 23, horizontal: 32),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
