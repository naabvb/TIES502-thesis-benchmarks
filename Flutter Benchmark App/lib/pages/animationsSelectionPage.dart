import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:gradu_flutter_bench/widgets/osSpecificButton.dart';
import 'animationsPage.dart';

class AnimationsSelectionPage extends StatelessWidget {
  AnimationsSelectionPage(this.title);
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
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AnimationsPage(4))),
                'Low intensity'),
            OSSpecificButton(
                () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AnimationsPage(8))),
                'Medium intensity'),
            OSSpecificButton(
                () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnimationsPage(16))),
                'High intensity'),
          ],
        ),
      ),
    );
  }
}
