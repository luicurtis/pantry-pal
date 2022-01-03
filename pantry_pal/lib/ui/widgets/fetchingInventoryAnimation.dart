import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget fetchingInventoryAnimation() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Fetching Inventory',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 25),
        SpinKitRing(
          color: Colors.black,
        ),
      ],
    ),
  );
}
