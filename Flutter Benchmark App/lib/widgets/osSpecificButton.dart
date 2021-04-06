import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OSSpecificButton extends StatelessWidget {
  OSSpecificButton(this.callback, this.text);

  final String text;
  final VoidCallback callback;
  final bool isIOS = Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    return (isIOS
        ? Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: CupertinoButton(
              child: Text(text),
              onPressed: callback,
            ),
          )
        : ElevatedButton(
            child: Text(text),
            onPressed: callback,
          ));
  }
}
