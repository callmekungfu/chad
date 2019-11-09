import 'package:client/models/role.dart';
import 'package:flutter/material.dart';
import 'package:client/models/user.dart';

class Body extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  String password;
  Role _role;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email';
    else
      return null;
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
                        decoration: InputDecoration(labelText: 'First name'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                        onSaved: (val) => setState(() => _user.firstName = val),
                      ),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Last name'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your last name.';
                            }
                            return null;
                          },
                          onSaved: (val) =>
                              setState(() => _user.lastName = val)),
                      TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return this.validateEmail(value);
                          },
                          onSaved: (val) =>
                              setState(() => _user.userName = val)),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a password.';
                          } else if (value.length < 8) {
                            return 'Password must contain more than 8 characters.';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          this.password = val;
                        },
                      ),
                      TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Re-enter password'),
                          validator: (value) {
                            if (value != this.password) {
                              return 'Please ensure that both passwords match.';
                            }
                            return null;
                          },
                          onSaved: (val) =>
                              setState(() => _user.password = val)),
                      DropdownButtonFormField<Role>(
                        hint: new Text('Select a role'),
                        items: Role.values.map((Role role) {
                          String s =
                              role.toString().split('.').last.toLowerCase();
                          return new DropdownMenuItem<Role>(
                              value: role,
                              child: new Text(
                                  '${s[0].toUpperCase()}${s.substring(1)}'));
                        }).toList(),
                        value: _role,
                        onChanged: (Role role) {
                          setState(() {
                            _role = role;
                          });
                        },
                        validator: (Role value) {
                          if (value == null) {
                            return 'Please pick an assigned role';
                          }
                          return null;
                        },
                        onSaved: (val) => setState(() => _user.role = val),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: RaisedButton(
                              onPressed: () async {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  _showPending(context);
                                  Map<String, dynamic> response =
                                      await _user.create();
                                  if (response['statusCode'] == 200) {
                                    _showSuccess(context);
                                  } else {
                                    _showFailure(context, response['msg']);
                                  }
                                }
                              },
                              child: Text('Create'))),
                    ]))));
  }

  _showPending(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Creating user'),
      backgroundColor: Colors.orange,
    ));
  }

  _showSuccess(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('User created'),
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
