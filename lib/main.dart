import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        backgroundColor: Colors.greenAccent[400],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondRoute()),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.greenAccent[400],
        child: Container(height: 50.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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

// ------------- SECOND ROUTE --------------------

class SecondRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Prayer Contact',
      home: new SecondRoute(),
    );
  }
}

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() {
    return _SecondRouteState();
  }
}

class _SecondRouteState extends State<SecondRoute> {
  final formKey = GlobalKey<FormState>();
  String _name, _prayer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Prayer Contact.")
      ),
      body: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Name'
                    ),
                    onSaved: (input) => _name = input,
                  ),
//                  TextFormField(
//                    decoration: InputDecoration(
//                        labelText: 'Prayer'
//                    ),
//                    onSaved: (input) => _prayer = input,
//                  ),
                  RaisedButton(
                    onPressed: (){
                      _submit();
                      Navigator.pop(context);
                    },
                    child: Text('Create Contact'),
                  ),
                ]
            ),
          ),
        ),
      )
    );
    }

  void _submit() {
    formKey.currentState.save();
    print(_name);
//    print(_prayer);
    Firestore.instance.collection('people').document().setData({'name':_name});

  }
}


