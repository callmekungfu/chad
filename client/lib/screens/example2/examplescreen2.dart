import 'package:flutter/material.dart';
import 'package:client/screens/example2/components/body.dart';

class ExScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Body(),
    );
  }
}
