import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:gradu_flutter_bench/widgets/osSpecificButton.dart';
import 'dart:io' show Platform;
import '../constants.dart';

class GpsPage extends StatefulWidget {
  @override
  _GpsPageState createState() => _GpsPageState(title);
}

class _GpsPageState extends State<GpsPage> {
  _GpsPageState(this.title);

  final String title;
  String execTime = '';
  double lat;
  double lon;
  double accuracy;
  Stopwatch stopwatch = new Stopwatch();
  final bool isIOS = Platform.isIOS;
  timer() {
    stopwatch.reset();
    stopwatch.start();
    determinePosition();
    return;
  }

  void determinePosition() {
    Geolocator.getCurrentPosition(
            desiredAccuracy:
                isIOS ? LocationAccuracy.best : LocationAccuracy.medium)
        .then((Position position) {
      setState(() {
        execTime = '${stopwatch.elapsedMilliseconds} ms';
        lat = position.latitude;
        lon = position.longitude;
        accuracy = position.accuracy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isIOS
          ? CupertinoNavigationBar(
              middle: Text(title),
            )
          : AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OSSpecificButton(() => timer(), 'Run GPS benchmark'),
            Text(lat.toString() + ' - ' + lon.toString()),
            Text('Accuracy: ' + accuracy.toString()),
            Text(execTime)
          ],
        ),
      ),
    );
  }
}
