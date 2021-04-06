import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradu_flutter_bench/widgets/osSpecificButton.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import '../constants.dart';

class UtilitiesPage extends StatefulWidget {
  @override
  _UtilitiesPageState createState() => _UtilitiesPageState(title);
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  _UtilitiesPageState(this.title);
  final String title;
  final bool isIOS = Platform.isIOS;
  String jsonExecTime = '';
  String cryptoExecTime = '';
  Stopwatch stopwatch = new Stopwatch();

  void fetchAlbum() async {
    final response = await http.get(
        'https://raw.githubusercontent.com/naabvb/TIES502-thesis-benchmarks/master/Assets/10mb-sample.json');
    if (response.statusCode == 200) {
      stopwatch.reset();
      stopwatch.start();
      var data = response.body;
      jsonDecode(data);
      setState(() {
        jsonExecTime =
            '${stopwatch.elapsedMilliseconds} ms';
      });
      stopwatch.reset();
    } else {
      throw Exception('Failed to load album');
    }
  }

  decodeJSON(data) {
    return jsonDecode(data);
  }

  void cryptoMark() {
    stopwatch.reset();
    stopwatch.start();
    for (int i = 0; i < 800000; i++) {
      createHMAC(i);
    }
    setState(() {
      cryptoExecTime =
          '${stopwatch.elapsedMilliseconds} ms';
    });
    stopwatch.reset();
  }

  Digest createHMAC(i) {
    var key = utf8.encode('test-key');
    var bytes = utf8.encode("verysecretteststring" + i.toString());
    var hmacSha256 = new Hmac(sha256, key);
    return hmacSha256.convert(bytes);
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
            OSSpecificButton(() => Navigator.pushNamed(context, '/gpspage'),
                'GPS benchmark'),
            OSSpecificButton(() => cryptoMark(), 'Run Crypto benchmark'),
            if (cryptoExecTime.length > 0) Text(cryptoExecTime),
            OSSpecificButton(() => fetchAlbum(), 'Run JSON benchmark'),
            if (jsonExecTime.length > 0) Text(jsonExecTime)
          ],
        ),
      ),
    );
  }
}
