import 'package:client/screens/service-management/service-management.dart';
import 'package:flutter/material.dart';
import 'package:client/models/service.dart';

class Body extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Body> {
  
  Future<List<Service>> service;

  //Service.getServiceList()

  @override
  void initState() {
    super.initState();

    // initial load
    setState(() {
      service = Service.getServiceList();
    });
    print("init");
    
  }

  void refreshList() {
    // reload
    setState(() {
      service = Service.getServiceList();
    });

    print("refresh");
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
        future: service = Service.getServiceList(),
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
                  trailing: Container(
                    width: 100.0,
                    child: Row(children: <Widget>[
                    IconButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context)=> ServiceManagementForm(service:snapshot.data[index]))); //TODO pass service object to editor screen snapshot.data[index]
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async{
                       bool result = await snapshot.data[index].delete();
                       if(result){
                         refreshList();
                       }else{
                         print("error");
                       }
                    },
                    icon: Icon(Icons.delete),
                  ),
                  ],),
                    ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Role: "+snapshot.data[index].role),
                      Text("Price: \$"+snapshot.data[index].price.toString()),
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


