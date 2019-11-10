import 'package:client/screens/admin/admin-screen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child : Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
          },
          child: Text('Admin Page'),
        ),
        new RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
          },
          child: Text('Service Browser'),
        )
      ],
    ));
  }
}
