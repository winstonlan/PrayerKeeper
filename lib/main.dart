import 'package:flutter/material.dart';

void main() => runApp(new PrayerKeeperApp());

class PrayerKeeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Prayer Keeper',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Prayer Keeper'),
        ),
      ),
    );
  }
}

