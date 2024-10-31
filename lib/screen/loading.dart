import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screen/weather_screen.dart';

const String APIKEY = 'b1b15e88fa797225412429c1c50c122a1';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? myLongitude2;
  double? myLatitude2;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    myLongitude2 = myLocation.myLongitude;
    myLatitude2 = myLocation.myLatitude;

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$myLatitude2&lon=$myLongitude2&appid=$APIKEY&units=metric');
    var weather = await network.getJsonData();
    if (!mounted) return;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(
                  parseWeatherData: weather,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: const Center(
          child: SpinKitFadingCircle(
            color: Colors.white,
            size: 80,
          ),
        ));
  }
}
