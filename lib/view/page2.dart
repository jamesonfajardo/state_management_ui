import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 2')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(),
          Text('Data 1'),
          SizedBox(height: 16),
          Text('Data 2'),
          SizedBox(height: 16),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Type something..',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onChanged: (newValue) {},
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/page3');
            },
            child: Text('Go down the widget tree'),
          ),
        ],
      ),
    );
  }
}
