import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// use this as a homepage? : https://www.youtube.com/watch?v=c063ddhWafo&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ&index=15&t=261s

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
