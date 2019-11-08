import 'package:client/screens/admin/admin-screen.dart';
import 'package:flutter/material.dart';
import 'package:client/models/service.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Body> {
  
  Future<List<Service>> _getUsers() async {
    var response = await http
        .get("http://www.json-generator.com/api/json/get/cjUkMLeZqq?indent=2");

    var jsonData = json.decode(response.body);

    List<Service> services = [];

    for (var s in jsonData) {
      Service service = Service(s['service_id'], s['name'], s['price'], s['role']);
      services.add(service);
    }

    return services;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: Center(
              child: Text("Loading..."),
            ));
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].name),
                  trailing: IconButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> AdminScreen())); //TODO pass service object to editor screen snapshot.data[index]
                    },
                    icon: Icon(Icons.edit),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Price: \$"+snapshot.data[index].price.toString()),
                      Text("Role: "+snapshot.data[index].role),
                      
                    ],
                  ),
                  onTap: (){
                    
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
        });
  }
}


