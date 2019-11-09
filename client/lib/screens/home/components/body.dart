import 'package:flutter/material.dart';
import 'package:client/models/user.dart';

class Body extends StatelessWidget {
  final User user;
  Body({Key key, @required this.user}) : super(key: key);

  String promptBuilder(User user) {
    return 'Welcome ${user.firstName} ${user.lastName}, you are logged in as ${user.role.toString().split('.').last.toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(promptBuilder(user)),
      ),
    );
  }
}
