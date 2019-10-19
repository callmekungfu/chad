import 'package:flutter/material.dart';
import 'package:client/screens/home/components/body.dart';
import 'package:client/models/user.dart';

class Home extends StatelessWidget {
  final User user;
  Home({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Body(user: user,),
    );
  }
}
