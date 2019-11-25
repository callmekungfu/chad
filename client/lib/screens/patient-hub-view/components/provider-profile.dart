import 'package:client/models/providerProfile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              style: TextStyle(fontSize: 36),
            ),
            margin: new EdgeInsets.only(bottom: 10),
          ),
          Container(
            child: Text(
              data.description,
            ),
            margin: EdgeInsets.only(bottom: 20),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: FlatButton.icon(
                    icon: Icon(Icons.map),
                    label: Text(data.address, style: TextStyle(color: Colors.blue),),
                    onPressed: () async {
                      final url = Uri.encodeFull('http://maps.google.com/?q=${data.address}');
                      if (await canLaunch(url)) {
                        launch(url);
                      }
                    },
                  ),
                ),
                Container(
                  child: FlatButton.icon(
                    icon: Icon(Icons.phone,),
                    label: Text(data.phoneNumber, style: TextStyle(color: Colors.blue),),
                    onPressed: () async {
                      final url = 'tel:${data.phoneNumber}';
                      if (await canLaunch(url)) {
                        launch(url);
                      }
                    },
                  ),
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: 30),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
      padding: EdgeInsets.all(20)
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
              child: Padding(padding: EdgeInsets.only(bottom: 10, top: 10), child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[Text(capitalize(key))],
              )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(data[key]),
                ],
              )
            ),
          ])
        );
      } else {
        rows.add(
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(padding: EdgeInsets.only(bottom: 10, top: 10), child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text(capitalize(key))],
              )),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text('Closed', style: TextStyle(color: Colors.black26),),],
              )
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