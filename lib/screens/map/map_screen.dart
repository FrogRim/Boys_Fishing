import 'package:flutter/material.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'weather.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(35.1379222, 129.05562775);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('지도'),
          backgroundColor: Colors.white,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: Color.fromARGB(255, 51, 195, 235),
          child: Icon(Icons.cloud, size: 40, color: Colors.white),
          onPressed: _showTopModal,
        ),
      ),
    );
  }

  Future<void> _showTopModal() async {
    final value = await showTopModalSheet<String>(
      context,
      const WeatherScreen(),
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );
  }
}

/*
class DummyModal extends StatelessWidget {
  const DummyModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16),
          const Text(
            "Today's Weather",
            style: TextStyle(color: Colors.blue, fontSize: 20),
            textAlign: TextAlign.center
            ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/weather/weather.png',
            width: 100,
	          height: 180,
	          fit: BoxFit.cover
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}*/