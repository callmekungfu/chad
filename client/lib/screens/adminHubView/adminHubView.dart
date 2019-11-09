import 'package:client/screens/example1/components/body.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/adminHubView/components/body.dart';
import 'package:client/models/user.dart';


class AdminHubView extends StatelessWidget {
@Override 
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Admin Hub"),
      ),
      body: Body(user: user,),
  );
}
}