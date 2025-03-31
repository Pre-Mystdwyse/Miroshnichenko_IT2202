import 'package:flutter/material.dart';

class SimpleList extends StatelessWidget {
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('0000'),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('0001'),
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('0010'),
        ),
      ],
    );
  }
}