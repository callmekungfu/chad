import 'package:client/screens/admin/components/body.dart';
import 'package:client/screens/service-management/service-management.dart';
import 'package:client/screens/serviceBrowser/components/body.dart' as serviceProvider;
import 'package:flutter/material.dart';


class AdminHubView extends StatefulWidget {
  @override
  _AdminHubViewState createState() => _AdminHubViewState();
}

class _AdminHubViewState extends State<AdminHubView> {
  int _selectedIndex = 0;
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Administration Center")),
      body: _selectedIndex == 0 ? Body() : serviceProvider.Body(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Create User'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Service Browser'),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: this._selectedIndex == 1 ? FloatingActionButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context)=> ServiceManagementForm()));
        },
        child: Icon(Icons.add),
      ) : null,
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}