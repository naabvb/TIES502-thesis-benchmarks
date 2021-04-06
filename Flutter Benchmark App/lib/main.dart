import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:gradu_flutter_bench/pages/animationsSelectionPage.dart';
import 'package:gradu_flutter_bench/pages/gpsPage.dart';
import 'package:gradu_flutter_bench/pages/utilitiesPage.dart';
import 'package:gradu_flutter_bench/widgets/osSpecificButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Flutter Bench';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SelectionPage(title),
        '/utilities': (context) => UtilitiesPage(),
        '/gpspage': (context) => GpsPage(),
        '/animationsselection': (context) => AnimationsSelectionPage(title)
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class SelectionPage extends StatelessWidget {
  SelectionPage(this.title);
  final String title;
  final bool isIOS = Platform.isIOS;

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
            OSSpecificButton(
                () => Navigator.pushNamed(context, '/animationsselection'),
                'Animations benchmarks'),
            OSSpecificButton(() => Navigator.pushNamed(context, '/utilities'),
                'Utilities benchmarks'),
          ],
        ),
      ),
    );
  }
}
