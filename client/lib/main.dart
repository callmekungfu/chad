import 'package:client/screens/employee-hub-view/components/service-list.dart';
import 'package:client/screens/employee-hub-view/employee-hub-view.dart';
import 'package:client/screens/service-management/service-management.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/login/login.dart';
import 'package:client/screens/admin/admin-screen.dart';
import 'package:client/screens/serviceBrowser/service-browser-screen.dart';
import 'package:client/screens/adminHubView/adminHubView.dart';
import 'package:client/screens/providerProfile/providerProfile.dart';

void main() {
  runApp(ChadApp());
}
class ChadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      MaterialApp(
        title: 'CHAD Clinic',
        initialRoute: '/service-provider',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => LoginScreen(),
          "/admin/service/form": (BuildContext context) => ServiceManagementForm(),
          "/admin/user": (BuildContext context) => AdminScreen(),
          "/admin/service": (BuildContext context) => ServiceBrowserScreen(),
          "/admin": (BuildContext context) => AdminHubView(),
          "/service-provider": (BuildContext context) => EmployeeHubView(),
          "/service-provider/list": (BuildContext context) => ServiceListWidget(),
          "/service-provider/form": (BuildContext context) => ProfileScreen(),
        },
      );
  }
}
