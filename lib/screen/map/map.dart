import 'package:dart_boysfishing/constants.dart';
import 'package:flutter/material.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});
 
  @override
  State<MapPage> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('지도'),
          backgroundColor: Colors.white,
        ),
        body: Text("Map Api"),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 5,
          backgroundColor: c_LogoBrightColor,
          child: Icon(Icons.cloud, size: 40, color: Colors.white),
          onPressed: _showTopModal,
        ),
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
            textAlign: TextAlign.center
            ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/weather.png',
            width: 100,
	          height: 180,
	          fit: BoxFit.cover
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}