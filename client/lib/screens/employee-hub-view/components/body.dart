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
  Future<ProviderProfile> profile;
  User user;

  _MyAppState({@required this.user});

  @override
  void initState() {
    super.initState();
    refreshProfile();
  }

  void refreshProfile() async {
    setState(() async {
      profile = ProviderProfile.getProviderProfile(user.provider);
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
            data.id = user.provider;
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
                            children: generateTableEditable(data),
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

  generateTableEditable(ProviderProfile profile) {
    var data = profile.availabilities.toMap();
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
                  toggleOpenClosed(key, profile);
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
                    if (time != null) {
                      int startTimeNumber = int.parse(time.toString().replaceAll(RegExp(r'[^0-9]'), ''));
                      int endTimeNumber = int.parse(endTime(data[key]).replaceAll(RegExp(r'[^0-9]'), ''));
                      if (startTimeNumber >= endTimeNumber) {
                        _showFailure(context, 'Invalid time');
                      } else {
                        setTime(time, key, true, profile);
                      }
                    }
                  },),
                  FlatButton(child: Text(endTime(data[key])), onPressed: () async {
                    TimeOfDay time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.parse(formatDT(endTime(data[key])))),
                    );
                    if (time != null) {
                      int endTimeNumber = int.parse(time.toString().replaceAll(RegExp(r'[^0-9]'), ''));
                      int startTimeNumber = int.parse(startTime(data[key]).replaceAll(RegExp(r'[^0-9]'), ''));
                      if (startTimeNumber >= endTimeNumber) {
                        _showFailure(context, 'Invalid time');
                      } else {
                        setTime(time, key, false, profile);
                      }
                    }
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

  toggleOpenClosed(String date, ProviderProfile profile) {
    var current = profile.availabilities.toMap();
    var val = current[date];
    if (val == 'closed') {
      current[date] = '09:00 - 17:00';
    } else if (val != 'closed') {
      current[date] = 'closed';
    }
    setState(() {
      profile.availabilities.fromMap(current);
      profile.update();
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

  setTime(TimeOfDay time, String date, bool start, ProviderProfile profile) {
    if (time == null) {
      return;
    }
    var current = profile.availabilities.toMap();
    var val = current[date];
    if (start) {
      var end = endTime(val);
      current[date] = timeStringBuilder(time.hour, time.minute) + ' - ' + end;
    } else {
      var start = startTime(val);
      current[date] = start + ' - ' + timeStringBuilder(time.hour, time.minute);
    }

    setState(() {
      profile.availabilities.fromMap(current);
      profile.update();
    });
  }

  _showPending(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Attempting to login'),
      backgroundColor: Colors.orange,
    ));
  }

  _showSuccess(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Login successful'),
      backgroundColor: Colors.green,
    ));
  }

  _showFailure(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
