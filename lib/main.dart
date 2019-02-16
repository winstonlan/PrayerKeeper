import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildPeopleList(context, dummySnapshot);
  }

  Widget _buildPeopleList(BuildContext context, List<Map> snapshot) {
    return ListView.builder(
      itemCount: dummySnapshot.length * 2,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return _buildRow(dummySnapshot[index]);
      }
    );
  }

  Widget _buildRow(Map data) {
    return ListTile(
      title: Text(data["name"]),
    );
  }
}

