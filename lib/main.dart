import 'package:flutter/material.dart';

void main() => runApp(new PrayerKeeperApp());

final dummySnapshot = [
  {"name": "Michael Scott"},
  {"name": "Jim Halpert"},
  {"name": "Pam Beasley"},
];

class PrayerKeeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Prayer Keeper',
      home: new PrayerKeeper(),
    );
  }
}

class PrayerKeeper extends StatefulWidget {
  @override
  _PrayerKeeperState createState() {
    return _PrayerKeeperState();
  }
}

class _PrayerKeeperState extends State<PrayerKeeper> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Prayer Keeper')
      ),
    );
  }
}
