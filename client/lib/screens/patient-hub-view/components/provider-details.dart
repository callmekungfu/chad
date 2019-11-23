import 'package:client/models/providerProfile.dart';
import 'package:client/screens/patient-hub-view/components/provider-profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ServiceProviderDetailsView extends StatefulWidget {
  ProviderProfile profile;

  ServiceProviderDetailsView({@required this.profile});
  @override
  _ServiceProviderDetailsViewState createState() => _ServiceProviderDetailsViewState();
}

class _ServiceProviderDetailsViewState extends State<ServiceProviderDetailsView> {
  int _selectedIndex = 0;

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile.companyName),
        ),
        body: this._selectedIndex == 0 ? ProviderProfileWidget(profile: widget.profile,) : null,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              title: Text('Clinic Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Clinic Services'),
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
        floatingActionButton: SpeedDial(
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          closeManually: false,
          tooltip: 'Clinic Service',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.star, color: Colors.black,),
              backgroundColor: Colors.white,
              label: 'Rate This Clinic',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')
            ),
            SpeedDialChild(
              child: Icon(Icons.check),
              backgroundColor: Colors.blue,
              label: 'Book an Appointment',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => print('SECOND CHILD'),
            ),
          ],
        ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}