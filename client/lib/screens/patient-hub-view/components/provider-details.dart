import 'package:client/models/providerProfile.dart';
import 'package:client/screens/patient-hub-view/components/provider-profile.dart';
import 'package:client/screens/patient-hub-view/components/provider-services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_rating/flutter_rating.dart';

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
      body: this._selectedIndex == 0 ? ProviderProfileWidget(profile: widget.profile,)
                                      : ProviderServiceListWidget(id: widget.profile.id,),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            title: Text('Clinic Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Clinic Services'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            title: Text('Clinic Ratings'),
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
            onTap: () async {
              var val = await showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text('Rate ${widget.profile.companyName}', textAlign: TextAlign.center,),
                    contentPadding: EdgeInsets.all(20),
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: StarRating(
                            size: 40,
                            onRatingChanged: (val) {
                              Navigator.of(context).pop(val);
                            },
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Text('Thank you for rating ${widget.profile.companyName}, your rating helps us better determine the quality of service provided.',
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                }
              );
              // TODO do something with `val`
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.check),
            backgroundColor: Colors.blue,
            label: 'Book an Appointment',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () async {
              var res = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Are you sure?'),
                    content: SingleChildScrollView(
                      child: Column(children: <Widget>[
                        Text('You are about to create an appointment with ${widget.profile.companyName}, the estimated wait time is:'),
                        Center(child: Text('15 min', style: TextStyle(fontSize: 36),),)
                      ],),
                    ),
                    actions: <Widget>[
                      FlatButton(child: Text('Book Appointment'), onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      FlatButton(child: Text('Cancel'), onPressed: () {Navigator.of(context).pop(false);},),
                    ],
                  );
                }
              );
              if (res != null && res) {
                // TODO Do appointment
              }
            }
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