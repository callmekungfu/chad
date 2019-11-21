import 'package:client/models/providerProfile.dart';
import 'package:client/models/user.dart';
import 'package:client/screens/providerProfile/providerProfile.dart';
import 'package:flutter/material.dart';
import 'package:client/models/service.dart';

class Body extends StatefulWidget {
  User user;
  Body({@required this.user});

  @override
  _MyAppState createState() => _MyAppState(user: user);
}

class _MyAppState extends State<Body> {
  Future<dynamic> profile;
  Map<String, String> availability;
  User user;

  _MyAppState({@required this.user});

  @override
  void initState() {
    super.initState();
    refreshAvailabilities();
    refreshProfile();
  }

  void refreshProfile() async {
    setState(() {
      profile = ProviderProfile.getProviderProfile(user.provider);
    });
  }
  void refreshAvailabilities() {
    // reload
    setState(() {
      availability = {
        'monday': '11:30 - 12:30',
        'tuesday': 'closed',
        'wednesday': '11:30 - 12:30',
        'thursday': '11:30 - 12:30',
        'friday': 'closed',
        'saturday': '11:30 - 12:30',
        'sunday': '11:30 - 12:30',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProviderProfile>(
        future: profile,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
              child: Text("Loading..."),
            ));
          } else {
            ProviderProfile data = snapshot.data;
            return SingleChildScrollView(
              child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: generateStatusTag(data.liscensed),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    child: Text(
                      data.companyName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    margin: new EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    child: Text(
                      data.description,
                      textAlign: TextAlign.center,
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(data.address),
                        ),
                        Container(
                          child: Text(data.phoneNumber),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 30),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Availability',
                            style: TextStyle(fontSize: 20),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        Container(
                          child: Text('Click on the day to toggle open and closed, then set the start and end time.', 
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        Container(
                          child: Table(
                            children: generateTableEditable(),
                          )
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 40),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: RaisedButton.icon(
                            color: Colors.blueAccent,
                            textColor: Colors.white,
                            icon: Icon(Icons.edit),
                            label: Text('Modify Profile'),
                            onPressed: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ProfileScreen(id: user.provider, user: user,))
                              );
                              refreshProfile();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(40)
            )
            );
          }
        });
  }

  generateTableEditable() {
    var data = this.availability;
    List<TableRow> rows = [];
    for (final key in data.keys) {
      rows.add(
        TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.all(0), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[FlatButton(child: Text(capitalize(key)), onPressed: () {
                  toggleOpenClosed(key);
                },)],
              )),
            ),
          ]
        )
      );
      if (data[key] != 'closed') {
        rows.add(
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.all(0), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(child: Text(startTime(data[key])), onPressed: () async {
                    TimeOfDay time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.parse(formatDT(startTime(data[key])))),
                    );
                    setTime(time, key, true);
                  },),
                  FlatButton(child: Text(endTime(data[key])), onPressed: () async {
                    TimeOfDay time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.parse(formatDT(endTime(data[key])))),
                    );
                    setTime(time, key, false);
                  },)
                ],
              )),
            ),
          ])
        );
      } else {
        rows.add(
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text('Closed', style: TextStyle(color: Colors.black26),),],
              )),
            )
          ])
        );
      }
      
    }
    return rows;
  }

  startTime(String combined) {
    return combined.split(' - ')[0];
  }

  endTime(String combined) {
    return combined.split(' - ')[1];
  }

  formatDT(String time) {
    return '2019-12-12 ' + time +':00';
  }

  capitalize(String phrase) {
    return phrase[0].toUpperCase() + phrase.substring(1).toLowerCase();
  }

  toggleOpenClosed(String date) {
    var current = this.availability;
    var val = current[date];
    if (val == 'closed') {
      current[date] = '09:00 - 17:00';
    } else if (val != 'closed') {
      current[date] = 'closed';
    }
    setState(() {
      availability = current;
    });
  }

  timeStringBuilder(int hour, int minute) {
    String h, m;

    h = hour < 10 ? '0' + hour.toString() : hour.toString();
    m = minute < 10 ? '0' + minute.toString() : minute.toString();
    return h + ':' + m;
  }

  generateStatusTag(bool isLicensed) {
    return isLicensed ? Text('Licensed', style: TextStyle(color: Colors.green),) 
                      : Text('Not Licensed', style: TextStyle(color: Colors.red),);
  }

  setTime(TimeOfDay time, String date, bool start) {
    if (time == null) {
      return;
    }
    var current = this.availability;
    var val = current[date];
    if (start) {
      var end = endTime(val);
      current[date] = timeStringBuilder(time.hour, time.minute) + ' - ' + end;
    } else {
      var start = startTime(val);
      current[date] = start + ' - ' + timeStringBuilder(time.hour, time.minute);
    }

    setState(() {
      availability = current;
    });
  }
}
