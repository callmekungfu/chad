import 'package:client/models/service.dart';
import 'package:flutter/material.dart';

class ServiceListWidget extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceListWidget> {
  Future<List<Service>> services;

  @override
  void initState() {
    super.initState();
    refreshList();
  }

  void refreshList() {
    // reload
    setState(() {
      services = Service.getServiceList();

    });
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: services,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Container(
              child: Text('Loading...'),
            ),
          );
        }
        return Container(
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(snapshot.data[i].name),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
          ),
        );
      },
    );
  }
}