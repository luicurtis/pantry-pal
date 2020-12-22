import 'package:flutter/material.dart';

class AddEntry extends StatefulWidget {
  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding New Item'),
        actions: [
          FlatButton(
            onPressed: () {
              //TODO: Handle save
            },
            child: Text('SAVE')
            )
        ],
      ),
      body: new Text("Foo"),
    );
  }
}