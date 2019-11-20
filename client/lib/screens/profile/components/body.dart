import 'package:flutter/material.dart';
import 'package:client/models/profile.dart';
import 'package:client/models/user.dart';

class Body extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();

  final User user;
  Body({Key key, @required this.user}) : super(key: key);
}

class _HomeMaterialState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  Profile _profile = new Profile(liscensed: false);

  // Form Text Field Controls
  final controls = {
    'companyName': new TextEditingController(),
    'phoneNumber': new TextEditingController(),
    'address': new TextEditingController(),
    'description': new TextEditingController(),
  };

  @override
  void initState(){
    fetchProfile();
    super.initState();
  }

  void fetchProfile() async{
    var existingProfile = await Profile.getUserProfile(widget.user.id);
    setState((){
      if (existingProfile != null) {
        _profile = existingProfile;
        controls['companyName'].text = _profile.companyName;
        controls['phoneNumber'].text = _profile.phoneNumber;
        controls['address'].text = _profile.address;
        controls['description'].text = _profile.description;
      } else if (widget.user != null) {
        _profile.userId = widget.user.id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Company Name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your company name';
                          }
                          return null;
                        },
                        controller: controls['companyName'],
                        onSaved: (val) =>
                            setState(() => _profile.companyName = val),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Phone Number'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                        controller: controls['phoneNumber'],
                        onSaved: (val) =>
                            setState(() => _profile.phoneNumber = val),
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Address'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          controller: controls['address'],
                          onSaved: (val) =>
                              setState(() => _profile.address = val)),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Description'),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: controls['description'],
                          onSaved: (val) =>
                              setState(() => _profile.description = val)),
                      CheckboxListTile(
                        title: const Text('Valid License'),
                        value: _profile.liscensed,
                        onChanged: (val) =>
                            setState(() => _profile.liscensed = val),
                      ),
                      RaisedButton(
                          onPressed: () async {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              _showPending(context);
                              Map<String, dynamic> response =
                                  await _profile.create();
                              if (response['statusCode'] == 200) {
                                _showSuccess(context);
                              } else {
                                _showFailure(context, response['msg']);
                              }
                            }
                          },
                          child: Text('Save'))
                    ]))));
  }

  _showPending(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Saving Profile'),
      backgroundColor: Colors.orange,
    ));
  }

  _showSuccess(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Profile Saved'),
      backgroundColor: Colors.green,
    ));
  }

  _showFailure(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
