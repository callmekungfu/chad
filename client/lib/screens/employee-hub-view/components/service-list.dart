import 'package:client/models/providerProfile.dart';
import 'package:client/models/service.dart';
import 'package:client/models/user.dart';
import 'package:flutter/material.dart';

class ServiceListWidget extends StatefulWidget {
  User user;
  bool showAll;
  ServiceListWidget({@required this.user, @required this.showAll});

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceListWidget> {
  Future<List<Service>> services;
  Future<ProviderProfile> profile;
  bool showAll = false;

  @override
  void initState() {
    super.initState();
    refreshList();
    refreshProfile();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    setState(() {
      showAll = widget.showAll;
    });
    refreshList();
    refreshProfile();
  }

  void refreshProfile() async {
    profile = ProviderProfile.getProviderProfile(widget.user.provider);
  }

  void refreshList() {
    // reload
    setState(() {
      services = Service.getServiceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return showAll ? showAllBuilder() : showMyBuilder();
  }

  showAllBuilder() {
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
              return generateShowAllListTile(snapshot.data[i], widget.user);
            },
            
            separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
          ),
        );
      },
    );
  }

  showMyBuilder() {
    return FutureBuilder(
      future: profile,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: Container(
              child: Text('Loading...'),
            ),
          );
        }
        List<Service> data = snapshot.data.services;
        return Container(
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int i) {
              return generateShowMyListTile(data[i], widget.user);
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        );
      },
    );
  }

  generateShowAllListTile(Service data, User user) {
    return ListTile(
      title: Text(data.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Role: "+data.role),
          Text("Price: \$"+data.price.toString()),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          data.addToUser(user);
          _showSuccess(context);
        },
        icon: Icon(Icons.add),
      ),
    );
  }

  _showSuccess(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Service Successfully Added'),
      backgroundColor: Colors.green,
    ));
  }

  generateShowMyListTile(Service data, User user) {
    return ListTile(
      title: Text(data.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Role: "+data.role),
          Text("Price: \$"+data.price.toString()),
        ],
      ),
      trailing: IconButton(
        onPressed: () {
          data.removeFromUser(user);
          refreshProfile();
          refreshList();
        },
        icon: Icon(Icons.delete),
      ),
    );
  }
}