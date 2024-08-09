import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String weatherInfo = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    String apiKey = 'PGKQHB4PB6T48YPG57TPYM6XL';
    String location = 'Warsaw';
    String date1 = '2024-08-09';
    String date2 = '2024-08-09';

    final url =
        'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/$location/$date1/$date2?key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        data.keys.forEach((key) {
          print('$key: ${data[key]}');
        });

        setState(() {
          weatherInfo = data.toString();
        });
      } else {
        setState(() {
          weatherInfo = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        weatherInfo = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Page1(),
          Page2(weatherInfo: weatherInfo),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is Page 1'),
    );
  }
}

class Page2 extends StatelessWidget {
  final String weatherInfo;

  Page2({required this.weatherInfo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(weatherInfo),
    );
  }
}
