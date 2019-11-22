import 'package:flutter/material.dart';

class ServiceProviderBrowserWidget extends StatefulWidget {

  _ServiceProviderBrowserState createState() => _ServiceProviderBrowserState();
}

class _ServiceProviderBrowserState extends State<ServiceProviderBrowserWidget> {
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
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        )
      ),
    );
  }

}