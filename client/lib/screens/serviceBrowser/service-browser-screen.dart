import 'package:flutter/material.dart';
import 'package:client/screens/serviceBrowser/components/body.dart';
import 'package:client/screens/admin/admin-screen.dart';

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
          Navigator.push(context, new MaterialPageRoute(builder: (context)=> AdminScreen())); //TODO Change navigation to edit screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}