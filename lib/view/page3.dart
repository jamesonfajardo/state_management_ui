import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 3')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
          Text('Data 1'),
          SizedBox(height: 16),
          Text('Data 2'),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
