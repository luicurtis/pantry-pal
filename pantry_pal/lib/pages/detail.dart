import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final item = arguments["item"];
    print(arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text('${item["name"]}'),
      ),
      body: Row(
        children: [
          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.edit),
      ),
    );
  }
}