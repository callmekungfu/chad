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
  final _service = Service();
  final controls = {
    'name': new TextEditingController(),
    'role': new TextEditingController(),
    'price': new TextEditingController(),
  };

  @override
  void initState() {
    if (widget.service != null) {
      var s = widget.service;
      controls['name'].text = s.name;
      controls['role'].text = s.role;
      controls['price'].text = s.price != null ? s.price.toString() : null;
    }
    return super.initState();
  }

  Widget build(BuildContext context) {
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
              validator: (value) => validateEmpty(value, 'Service Name must be sepcified.'),
              controller: controls['name'],
              onSaved: (val) => setState(() => _service.name = val),
            ),
            TextFormField(
              maxLength: 120,
              decoration: InputDecoration(labelText: 'Role Responsible'),
              validator: (value) => validateEmpty(value, 'A role that provides this service must be specified.'),
              controller: controls['role'],
              onSaved: (val) => setState(() => _service.role = val),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              validator: (value) => validateEmpty(value, 'Service Price cannot be empty.'),
              controller: controls['price'],
              keyboardType: TextInputType.number,
              onSaved: (val) => setState(() => _service.price = double.parse(val)),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {
                  var form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    _showLoading(context);
                    if (widget.service == null) {
                      // DO POST
                      handlePost(this._service);
                    } else {
                      // DO PUT
                    }
                  }
                },
                child: Text(buttonText(widget.service)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handlePost(Service service) async {
    var res = await service.create();
    if (!res['isSuccess']) {
      _showFailure(context, res['msg']);
      return;
    }
    _showSuccess(context);
  }

  handlePut(Service service) async {
    var res = await service.update();
    if (!res['isSuccess']) {
      _showFailure(context, res['msg']);
      return;
    }
    _showSuccess(context);
  }

  String validateEmpty(String value, String prompt) {
    if (value.isEmpty) {
      return prompt;
    }
    return null;
  }

  buttonText(Service service) {
    return service != null ? 'Modify Service' : 'Create Service';
  }
  
  _showLoading(BuildContext context) {
    Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Creating Service...')));
  }

  _showFailure(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  _showSuccess(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Service Created!'),
      backgroundColor: Colors.green,
    ));
  }
}