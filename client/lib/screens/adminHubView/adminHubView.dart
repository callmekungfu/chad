import 'package:flutter/material.dart';
import 'package:client/screens/adminHubView/components/body.dart';


class AdminHubView extends StatelessWidget {
@override 
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("Admin Hub"),
      ),
      body: Body(),
  );
}
}