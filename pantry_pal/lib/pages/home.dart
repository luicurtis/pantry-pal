import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        child: Row(
          children: [
            FlatButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory');
              },
              icon: Icon(Icons.inventory),
              label: Text('Inventory')),
          ],
        ),
      ),
    );
  }
}
