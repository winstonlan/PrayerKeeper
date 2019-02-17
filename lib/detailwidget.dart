import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailWidget extends StatefulWidget {
  final String documentId;

  DetailWidget({Key key, @required this.documentId}) : super(key: key);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Prayer Requests')
      ),
      body: _buildBody(context),
      floatingActionButton: new FloatingActionButton(
        onPressed: _showDialog,
        child: new Icon(Icons.create),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final userDocumentId = widget.documentId;
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('people/$userDocumentId/prayer-req').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildPrayerList(context, snapshot.data.documents);
      }
    );
  }

  Widget _buildPrayerList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length * 2,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return _buildPrayerRequest(snapshot[index]);
      }
    );
  }

  Widget _buildPrayerRequest(DocumentSnapshot data) {
    return ListTile(
      title: Text(data['detail'])
    );
  }

  _showDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Prayer Request"),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new TextField(
                  decoration: new InputDecoration(hintText: 'Dear God...'),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('ADD'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }
}