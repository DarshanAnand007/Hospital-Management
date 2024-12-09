/// # Author Darshan Anand
/// Created on: 2024-12-09
/// Purpose: Demonstrates a Google Map with custom markers for hospital locations.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapScreen(),
    );
  }
}

class GoogleMapScreen extends StatefulWidget {
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  final List<Map<String, dynamic>> hospitals = [
    {'name': 'Hospital 1', 'location': LatLng(28.6139, 77.2090)}, // Delhi center
    {'name': 'Hospital 2', 'location': LatLng(28.7041, 77.1025)}, // North Delhi
    {'name': 'Hospital 3', 'location': LatLng(28.5355, 77.3910)}, // South Delhi
    {'name': 'Hospital 4', 'location': LatLng(28.4595, 77.0266)}, // Gurgaon
    {'name': 'Hospital 5', 'location': LatLng(28.4089, 77.3178)}, // Noida
  ];

  final Map<String, BitmapDescriptor> customIcons = {};

  @override
  void initState() {
    super.initState();
    _createCustomMarkers();
  }

  Future<void> _createCustomMarkers() async {
    for (var hospital in hospitals) {
      final markerIcon = await _getMarkerIcon(hospital['name']);
      customIcons[hospital['name']] = markerIcon;
    }
    setState(() {});
  }

  Future<BitmapDescriptor> _getMarkerIcon(String text) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final size = const Size(200, 200); // Increased size for bigger markers

    // Draw the red border circle
    final borderPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2.2, borderPaint);

    // Draw the white inner circle
    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2.5, fillPaint);

    // Add text inside the circle
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );

    final image = await pictureRecorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Locator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(28.6139, 77.2090),
          zoom: 11.0,
        ),
        markers: hospitals.map((hospital) {
          return Marker(
            markerId: MarkerId(hospital['name']),
            position: hospital['location'],
            icon: customIcons[hospital['name']] ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: hospital['name'],
              snippet: 'Click for details',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(hospitalName: hospital['name']),
                  ),
                );
              },
            ),
          );
        }).toSet(),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
      ),
    );
  }
}
