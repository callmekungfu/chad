import 'package:flutter/material.dart';
import 'package:client/models/service.dart';

class Body extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Body> {
  Future<dynamic> profile;
  Map<String, String> availability;

  @override
  void initState() {
    super.initState();
    refreshAvailabilities();
  }

  @override
  void didUpdateWidget(Widget old) {
    refreshAvailabilities();
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
    return FutureBuilder<List<Service>>(
        future: profile,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Container(
                child: Center(
              child: Text("Loading..."),
            ));
          } else {
            return SingleChildScrollView(
              child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Welcome to CHAD',
                      style: TextStyle(color: Colors.grey),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    child: Text(
                      'Jeff Beso\'s Masage Parlor',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    margin: new EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam venenatis aliquam justo, vitae aliquam felis consequat a. Etiam sit amet volutpat mi, non egestas sem. Morbi facilisis pharetra tempor.',
                      textAlign: TextAlign.center,
                    ),
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('1096 Bathgate Drive'),
                        ),
                        Container(
                          child: Text('Ottawa, Ontario. K1J 8G1'),
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
                              print('pressed');
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
                    print(timeStringBuilder(time.hour, time.minute));
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

  setTime(TimeOfDay time, String date, bool start) {
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
