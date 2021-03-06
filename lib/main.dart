import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detailwidget.dart';

void main() => runApp(new PrayerKeeperApp());

class PrayerKeeperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        title: new Text('Prayer Keeper'),
//        backgroundColor: Colors.greenAccent[400],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addContactDialogue,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('people').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildPeopleList(context, snapshot.data.documents);
      }
    );
  }

  Widget _buildPeopleList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length * 2,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        final index = i ~/ 2;
        return _buildRow(snapshot[index]);
      }
    );
  }

  Widget _buildRow(DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return ListTile(
      title: Text(record.name),
      leading: CircleAvatar(
//          backgroundColor: Colors.lightBlue[400],
          child: Text(record.name[0])),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailWidget(documentId: data.documentID),
          )
        );
      },
    );
  }

  _addContactDialogue() async{
    final contactTextFieldController = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Who am I praying for?"),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(),
                controller: contactTextFieldController,
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed:(){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: (){
                Firestore.instance.collection('people').document().setData({'name': contactTextFieldController.text});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Record {
  final String name;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      name = map['name'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}



