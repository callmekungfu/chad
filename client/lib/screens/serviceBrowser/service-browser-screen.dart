import 'package:client/screens/service-management/service-management.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/serviceBrowser/components/body.dart';


class ServiceBrowserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Active Services"),
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context)=> ServiceManagementForm()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}