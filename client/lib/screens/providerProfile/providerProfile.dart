import 'package:flutter/material.dart';
import 'package:client/screens/providerProfile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  final String id;

  ProfileScreen({Key key, this.id}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Body(id:id),
    );
  }
}
