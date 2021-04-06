import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpinnerWidget extends StatelessWidget {
  SpinnerWidget(this.controller, this.columns);

  final AnimationController controller;
  final int columns;
  final Image kuva =
      Image(width: 20, height: 10, image: AssetImage('assets/testikuva.jpg'));

  @override
  Widget build(BuildContext context) {
    return (Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < this.columns; i++)
          AnimatedBuilder(
              builder: (BuildContext context, Widget _widget) {
                return new Transform.rotate(
                    angle:
                        i % 2 == 0 ? controller.value : controller.value * -1,
                    child: _widget);
              },
              animation: controller,
              child: kuva),
      ],
    ));
  }
}
