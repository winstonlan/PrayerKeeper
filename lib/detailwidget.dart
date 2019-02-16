import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String name;

  DetailWidget({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
    );
  }
}