import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature:  json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}

class WeatherService {
  final String apiKey = '6dacdc029f1cedf1d76873f3b76707fd';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  
  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}