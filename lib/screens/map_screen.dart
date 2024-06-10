import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('피싱맵',
            style: TextStyle(
                fontFamily: 'Gamtanload',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
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
        backgroundColor: const Color.fromARGB(255, 51, 195, 235),
        child: const Icon(Icons.cloud, size: 40, color: Colors.white),
        onPressed: _showTopModal,
      ),
    );
  }

  Future<void> _showTopModal() async {
    final value = await showTopModalSheet<String>(
      context,
      const DummyModal(),
      backgroundColor: Colors.white,
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    );
  }
}

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
            "Weather Api",
            style: TextStyle(color: Colors.blue, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/icons/weather.png',
            width: 100,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
