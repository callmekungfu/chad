import 'package:client/models/user.dart';
import 'package:client/screens/patient-hub-view/components/provider-browser.dart';
import 'package:flutter/material.dart';

class PatientHubView extends StatefulWidget {
  User user;

  PatientHubView({@required this.user});
  @override
  _PatientHubViewState createState() => _PatientHubViewState();
}

class _PatientHubViewState extends State<PatientHubView> {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: ServiceProviderBrowserWidget(user: widget.user,),
    );
  }
}