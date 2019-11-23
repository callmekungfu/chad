import 'package:client/models/providerProfile.dart';
import 'package:client/models/service.dart';
import 'package:client/models/user.dart';
import 'package:flutter/material.dart';

class ProviderServiceListWidget extends StatefulWidget {
  String id;
  ProviderServiceListWidget({@required this.id});

  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ProviderServiceListWidget> {
  Future<ProviderProfile> profile;
  bool showAll = true;

  @override
  void initState() {
    super.initState();
    refreshProfile();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    refreshProfile();
  }

  void refreshProfile() async {
    profile = ProviderProfile.getProviderProfile(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return showMyBuilder();
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
              return generateShowMyListTile(data[i]);
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

  generateShowMyListTile(Service data) {
    return ListTile(
      title: Text(data.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Role: "+data.role),
          Text("Price: \$"+data.price.toString()),
        ],
      ),
    );
  }
}