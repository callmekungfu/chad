import 'package:client/models/service.dart';
import 'package:flutter/material.dart';

class ServiceFormWidget extends StatefulWidget {
  final Service service;
  ServiceFormWidget({Key key, this.service}) : super(key: key);
  @override
  ServiceFormWidgetState createState() {
    return ServiceFormWidgetState();
  }
}

class ServiceFormWidgetState extends State<ServiceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  
  Widget build(BuildContext context) {
    Service _service = widget.service != null ? widget.service : Service();
    Map<String, TextEditingController> model = {
      'name': new TextEditingController(text: _service.name),
      'role': new TextEditingController(text: _service.role),
      'price': new TextEditingController(text: _service.price != null ? _service.price.toString() : null),
    };
    return 
    SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              maxLength: 120,
              decoration: InputDecoration(labelText: 'Service Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Service Name cannot be empty.';
                }
                return null;
              },
              controller: model['name'],
              onSaved: (val) => setState(() => _service.name = val),
            ),
            TextFormField(
              maxLength: 120,
              decoration: InputDecoration(labelText: 'Role Responsible'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'A role that provides this service must be specified.';
                }
                return null;
              },
              controller: model['role'],
              onSaved: (val) => setState(() => _service.role = val),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Service Price cannot be empty.';
                }
                return null;
              },
              controller: model['price'],
              keyboardType: TextInputType.number,
              onSaved: (val) => setState(() => _service.price = double.parse(val)),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Create Service'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}