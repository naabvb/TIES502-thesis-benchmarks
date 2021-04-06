import 'package:flutter/material.dart';
import 'package:gradu_flutter_bench/widgets/osSpecificButton.dart';
import 'package:gradu_flutter_bench/widgets/spinnerWidget.dart';
import 'dart:math';

class AnimationsPage extends StatefulWidget {
  final columns;
  AnimationsPage(this.columns);
  @override
  _AnimationsPageState createState() => _AnimationsPageState(columns);
}

class _AnimationsPageState extends State<AnimationsPage>
    with TickerProviderStateMixin {
  _AnimationsPageState(this.columns);
  final int columns;
  AnimationController animationController;
  bool stopped = false;

  @override
  void initState() {
    super.initState();
    setState(() {});
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 500), upperBound: pi * 2);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 13; i++)
          SpinnerWidget(animationController, this.columns),
        animationController.isAnimating && !stopped
            ? OSSpecificButton(
                () => {
                      animationController.reset(),
                      setState(() => {stopped = true})
                    },
                'Stop')
            : OSSpecificButton(
                () => {
                      animationController.repeat(),
                      setState(() => {stopped = false})
                    },
                'Start')
      ],
    ));
  }
}
