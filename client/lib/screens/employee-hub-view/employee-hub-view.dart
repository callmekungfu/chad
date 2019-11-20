import 'package:client/screens/employee-hub-view/components/body.dart';
import 'package:flutter/material.dart';


class EmployeeHubView extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Provider Hub"),
        ),
        body: Body(),
    );
  }
}