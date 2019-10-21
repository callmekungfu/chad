import 'package:client/screens/example2/examplescreen2.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExScreen2()),
            );
        },
        child: Text('Go to second'),
      ),
    );
  }
}
