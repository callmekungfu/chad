import 'package:client/models/service.dart';
import 'package:flutter/material.dart';

import 'components/service-form.dart';

class ServiceManagementForm extends StatelessWidget {
  final Service service;

  // Constructor
  ServiceManagementForm({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Management"),
      ),
      body: ServiceFormWidget(service: service,)
    );
  }
}