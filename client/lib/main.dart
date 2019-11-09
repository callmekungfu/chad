import 'package:client/models/service.dart';
import 'package:client/screens/service-management/service-management.dart';
import 'package:flutter/material.dart';
import 'package:client/blocprovs/example-block-prov.dart';
import 'package:client/screens/login/login.dart';
import 'package:client/screens/example2/examplescreen2.dart';
import 'package:client/screens/admin/admin-screen.dart';
import 'package:client/screens/serviceBrowser/service-browser-screen.dart';

void main() {
  runApp(ExampleApp());
}
class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleProvider(
      child: MaterialApp(
        title: 'CHAD Clinic',
        initialRoute: '/serviceBrowser',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => LoginScreen(),
          // "/": (BuildContext context) => ServiceManagementForm(),
          "/ExScreen2": (BuildContext context) => ExScreen2(),
          "/admin": (BuildContext context) => AdminScreen(),
          "/serviceBrowser": (BuildContext context) => ServiceBrowserScreen(),
        },
      ),
    );
  }
}
