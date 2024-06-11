import 'weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService();
  Weather? _weather;

  _fetchWeather() async {
    String cityName = 'Busan';

    final weather = await _weatherService.getWeather(cityName);
    setState(() {
      _weather = weather;
    });
  }

  String getweatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/weather/cloud.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/weather/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/weather/rain.json';
      case 'thunderstorm':
        return 'assets/weather/thunder.json';
      case 'clear':
        return 'assets/weather/sunny.json';
      default:
        return 'assets/weather/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16),
          Container(
            //height: 160,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('')
                ),
                Expanded(
                  flex: 7,
                  child: Lottie.asset(getweatherAnimation(_weather?.mainCondition)),
                ),
                Expanded(
                  flex: 9,
                  child: Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          "Today's Weather",
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                          textAlign: TextAlign.center
                        ),
                        Text(_weather?.cityName ?? "loading city.."),
                        Text('${_weather?.temperature.round()}도'),
                      ],
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Text('')
                ),
              ]
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}