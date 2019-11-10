import 'package:client/models/service.dart';
import 'package:client/screens/serviceBrowser/service-browser-screen.dart';
import 'package:flutter/material.dart';

class ServiceFormWidget extends StatefulWidget {
  final Service service;
  // Constructor
  ServiceFormWidget({Key key, this.service}) : super(key: key);

  @override
  ServiceFormWidgetState createState() {
    return ServiceFormWidgetState();
  }
}

class ServiceFormWidgetState extends State<ServiceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  Service _service = Service();
  // Form Text Field Controls
  final controls = {
    'name': new TextEditingController(),
    'role': new TextEditingController(),
    'price': new TextEditingController(),
  };

  // ComponentDidMount
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

  // Render
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
              validator: (value) => validatePrice(value, 'Service Price cannot be empty.'),
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
                      handlePost(this._service);
                    } else {
                      this._service.id = widget.service.id;
                      handlePut(this._service);
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

  // Handles the post call action
  handlePost(Service service) async {
    var res = await service.create();
    if (!res['isSuccess']) {
      _showFailure(context, res['msg']);
      return;
    }
    _showSuccess(context, service);
    clearInputs(controls);
  }

  // Handles the put call action
  handlePut(Service service) async {
    var res = await service.update();
    if (!res['isSuccess']) {
      _showFailure(context, res['msg']);
      return;
    }
    _showSuccess(context, widget.service);
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => ServiceBrowserScreen(),
      )
    );
  }

  // Validator, checks if field is empty
  String validateEmpty(String value, String prompt) {
    if (value.isEmpty) {
      return prompt;
    }
    return null;
  }

  clearInputs(Map<String, TextEditingController> controls) {
    controls['name'].clear();
    controls['role'].clear();
    controls['price'].clear();
  }

  String validatePrice(String value, String prompt) {
    if (value.isEmpty) {
      return prompt;
    }
    return !isNumericPositive(value) ? 'Price must be a positive number' : null;
  }

  bool isNumericPositive(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s) != null && double.parse(s) >= 0;
}

  // Gets the button text depending on the role of the form
  buttonText(Service service) {
    return service != null ? 'Modify Service' : 'Create Service';
  }

  snackText(Service service) {
    return service.id != null ? 'Service Updated' : 'Service Created';
  }
  
  // Show loading snackbar
  _showLoading(BuildContext context) {
    Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text('Please wait...')));
  }

  // Show Failure snack bar
  _showFailure(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  // Show success snack bar
  _showSuccess(BuildContext context, Service service) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(snackText(service)),
      backgroundColor: Colors.green,
    ));
  }
}