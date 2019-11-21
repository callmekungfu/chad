import 'package:client/models/user.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/providerProfile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  final String id;
  User user;

  ProfileScreen({Key key, this.id, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Body(id:id, user: user,),
    );
  }
}
