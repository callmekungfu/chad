import 'package:flutter/material.dart';
import 'package:client/models/service.dart';

class Body extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Body> {
  Future<List<Service>> service;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  @override
  void didUpdateWidget(Widget old) {
    refreshList();
  }

  void refreshList() {
    // reload
    setState(() {
      service = Service.getServiceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
        future: service,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
              child: Text("Loading..."),
            ));
          } else {
            return Container(
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
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
                        Container(child: Table(
                          children: generateTable(),
                        ))
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 40),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: RaisedButton.icon(
                            color: Colors.blue,
                            textColor: Colors.white,
                            icon: Icon(Icons.calendar_today),
                            label: Text('Modify Availabilities'),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => popupBuilder(context)
                            );
                            },
                          ),
                        ),
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
            );
          }
        });
  }

  generateTable() {
    var data = {
      'monday': '11:30 - 12:30',
      'tuesday': 'closed',
      'wednesday': '11:30 - 12:30',
      'thursday': '11:30 - 12:30',
      'friday': 'closed',
      'saturday': '11:30 - 12:30',
      'sunday': '11:30 - 12:30',
    };
    List<TableRow> rows = [];

    for (final key in data.keys) {
      rows.add(
        TableRow(children: [
          TableCell(
            child: Padding(padding: EdgeInsets.all(5), child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(key)],
            )),
          ),
          TableCell(
            child: Padding(padding: EdgeInsets.all(5), child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text(data[key])],
            )),
          )
        ])
      );
    }
    return rows;
  }

  generateTableEditable() {
    var data = {
      'monday': '11:30 - 12:30',
      'tuesday': 'closed',
      'wednesday': '11:30 - 12:30',
      'thursday': '11:30 - 12:30',
      'friday': 'closed',
      'saturday': '11:30 - 12:30',
      'sunday': '11:30 - 12:30',
    };
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
                children: <Widget>[FlatButton(child: Text(capitalize(key),), onPressed: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                  );
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
                  FlatButton(child: Text(startTime(data[key])), onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
                  },),
                  FlatButton(child: Text(endTime(data[key])), onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    );
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

  capitalize(String phrase) {
    return phrase[0].toUpperCase() + phrase.substring(1).toLowerCase();
  }

  popupBuilder(BuildContext context) {
    return AlertDialog(
      title: Text('Modify Availabilities'),
      content: SingleChildScrollView(child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('Click on the day to toggle open and closed, then set the start and end time everyday'),
              margin: EdgeInsets.only(bottom: 10),
            ),
            Table(
              children: generateTableEditable(),
            )
          ],
        ),
      ),),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close')
        ),
      ],
    );
  }
}
