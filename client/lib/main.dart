import 'package:client/screens/service-management/service-management.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/login/login.dart';
import 'package:client/screens/admin/admin-screen.dart';
import 'package:client/screens/serviceBrowser/service-browser-screen.dart';

void main() {
  runApp(ChadApp());
}
class ChadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(
        title: 'CHAD Clinic',
        initialRoute: '/serviceBrowser',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => LoginScreen(),
          "/serviceManagement": (BuildContext context) => ServiceManagementForm(),
          "/admin": (BuildContext context) => AdminScreen(),
          "/serviceBrowser": (BuildContext context) => ServiceBrowserScreen(),
        },
      );
  }
}
