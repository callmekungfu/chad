import 'package:client/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/profile/components/body.dart';
import 'package:client/models/user.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  ProfileScreen({Key key, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Body(),
    );
  }
}
