import 'package:flutter/material.dart';
import 'package:client/models/user.dart';

class Body extends StatelessWidget {
  final User user;
  Body({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Welcome ${user.firstName} ${user.lastName}, you are logged in as ${user.srole}'),
      ),
    );
  }
}
