import 'package:client/models/providerProfile.dart';
import 'package:client/models/user.dart';
import 'package:client/screens/patient-hub-view/components/provider-details.dart';
import 'package:flutter/material.dart';

class ServiceProviderBrowserWidget extends StatefulWidget {
  User user;
  ServiceProviderBrowserWidget({@required this.user});
  _ServiceProviderBrowserState createState() => _ServiceProviderBrowserState();
}

class _ServiceProviderBrowserState extends State<ServiceProviderBrowserWidget> {
  Future<List<ProviderProfile>> list;
  String filter = '';
  
  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    setState(() {
      list = ProviderProfile.getProviderProfiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('Browse', 
                        textAlign: TextAlign.center, 
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Container(
                      child: Text('Find the clinic that best suits your needs', 
                        textAlign: TextAlign.center, 
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      margin: EdgeInsets.only(bottom: 40),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(100.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          hintText: 'Type Keyword',
                        ),
                        onChanged: (String input) {
                          setState(() {
                            this.filter = input;
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
            ),
            FutureBuilder<List<ProviderProfile>>(
              future: list,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(child: Text('Loading...'),);
                }
                List<ProviderProfile> dataList = snapshot.data;
                return generateListBody(filterList(dataList, this.filter));
              },
            ),
          ],
        )
      ),
    );
  }

  generateListBody(List<ProviderProfile> dataList) {
    List<Widget> wList = [];
    for (ProviderProfile p in dataList) {
      wList.addAll(generateListItem(p));
    }
    return Container(
      child: Column(
        children: wList
      ),
    );
  }

  generateListItem(ProviderProfile profile) {
    return [
      Divider(),
      ListTile(
        title: Text(profile.companyName),
        isThreeLine: false,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(profile.address),
            Container(child: StarDisplay(value: 3,), margin: EdgeInsets.only(top: 10),),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Wait time'),
            Text('15 min', style: TextStyle(fontSize: 24),),
          ],
        ),
        onTap: () {
          Navigator.push(context, 
            MaterialPageRoute(builder: (context) => ServiceProviderDetailsView(profile: profile, user: widget.user,),)
          );
        },
      ),
    ];
  }

  List<ProviderProfile> filterList(List<ProviderProfile> raw, String query) {
    var iter = raw.where((item) {
      return item.searchable.toLowerCase().contains(query.toLowerCase());
    });

    return iter.toList();
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: 16,
          color: Colors.amber,
        );
      }),
    );
  }
}