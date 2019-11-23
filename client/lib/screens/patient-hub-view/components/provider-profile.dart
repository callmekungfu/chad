import 'package:client/models/providerProfile.dart';
import 'package:flutter/material.dart';

class ProviderProfileWidget extends StatefulWidget {
  ProviderProfile profile;
  ProviderProfileWidget({@required this.profile});
  _ProviderProfileState createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfileWidget> {
  ProviderProfile data;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = widget.profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: generateStatusTag(data.liscensed),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Container(
            child: Text(
              data.companyName,
              style: TextStyle(fontSize: 24),
            ),
            margin: new EdgeInsets.only(bottom: 20),
          ),
          Container(
            child: Text(
              data.description,
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
                  child: Table(
                    children: generateTable(data),
                  )
                )
              ],
            ),
          ),
        ],
      ),
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(40)
      )
    );
  }

  generateTable(ProviderProfile profile) {
    var data = profile.availabilities.toMap();
    List<TableRow> rows = [];
    for (final key in data.keys) {
      if (data[key] != 'closed') {
        rows.add(
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.all(10), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(capitalize(key))],
              )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.all(5), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(data[key]),
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
              child: Padding(padding: EdgeInsets.all(10), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text(capitalize(key))],
              )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.all(5), child: Row(
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

  capitalize(String phrase) {
    return phrase[0].toUpperCase() + phrase.substring(1).toLowerCase();
  }

  generateStatusTag(bool isLicensed) {
    return isLicensed ? Text('Licensed', style: TextStyle(color: Colors.green),)
                      : Text('Not Licensed', style: TextStyle(color: Colors.red),);
  }
}