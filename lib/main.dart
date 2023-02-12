import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyMapApp());
}

class MyMapApp extends StatelessWidget {
  const MyMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapview'),
      ),
      body: const GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(23.80560326575505, 90.3745761108481)),
      ),
    );
  }
}
