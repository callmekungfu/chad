import 'package:flutter/material.dart';
import 'package:client/screens/admin/components/body.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      body: Body(),
    );
  }
}
