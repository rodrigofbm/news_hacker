import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Omg"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Hi");
          },
          child: Icon(Icons.add),
        ),
      );
  }
}