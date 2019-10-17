import 'package:flutter/material.dart';
import 'package:client/screens/example1/components/body.dart';

class ExScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
      body: Body(),
    );
  }
}
