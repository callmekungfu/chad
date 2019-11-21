import 'package:client/models/user.dart';
import 'package:client/screens/employee-hub-view/components/body.dart';
import 'package:client/screens/service-management/service-management.dart';
import 'package:flutter/material.dart';

import 'components/service-list.dart';


class EmployeeHubView extends StatefulWidget {
  User user;
  EmployeeHubView({Key key, this.user}) : super(key: key);

  @override
  _EmployeeHubViewState createState() => _EmployeeHubViewState(user: user);
}

class _EmployeeHubViewState extends State<EmployeeHubView> {
  int _selectedIndex = 0;
  User user;
  bool showAllServices = false;

  _EmployeeHubViewState({this.user});

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Provider Hub"),
        ),
        body: this._selectedIndex == 0 ? Body(user: user,) : ServiceListWidget(user: user, showAll: showAllServices,),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('My Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('My Services'),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
        floatingActionButton: this._selectedIndex == 1 ? FloatingActionButton(
          onPressed: () {
            setState(() {
              showAllServices = !showAllServices;
            });
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