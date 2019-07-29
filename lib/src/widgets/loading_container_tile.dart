import 'package:flutter/material.dart';

class LoadingContainerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildGrayBox(),
          subtitle: buildGrayBox(),
        ),
        Divider(height: 8.0,)
      ],
    );
  }

  Widget buildGrayBox() {
    return Container(
      height: 24.0,
      width: 150.0,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      color: Colors.grey[200],
    );
  }
}