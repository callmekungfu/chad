import 'package:client/screens/admin/admin-screen.dart';
import 'package:flutter/material.dart';
import 'package:client/models/credential.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/models/user.dart';
import 'package:client/models/role.dart';

class Body extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Body> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  final _credential = Credential();
  String name, email, mobile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: new Container(
        margin: new EdgeInsets.all(15.0),
        child: new Form(
          key: _key,
          autovalidate: _validate,
          child: FormUI(),
        ),
      ),
    );
  }

  Widget FormUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Username'),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateEmail,
            onSaved: (val) => setState(() => _credential.userName = val)),
        new TextFormField(
            decoration: new InputDecoration(hintText: 'Password'),
            maxLength: 32,
            obscureText: true,
            validator: validatePassword,
            onSaved: (val) => setState(() => _credential.password = val)),
        new SizedBox(height: 15.0),
        new RaisedButton(
            onPressed: () async {
              final form = _key.currentState;
              if (form.validate()) {
                form.save();
                _showPending(context);
                Map<String, dynamic> response = await _credential.login();
                if (response['statusCode'] == 200) {
                  Role role = convertToRole(response['role']);
                  if (role != null) {
                    _showSuccess(context);
                    User user = new User();
                    user.firstName = response['first_name'];
                    user.lastName = response['last_name'];
                    user.role = role;
                    if (user.role == Role.ADMINISTRATOR) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminScreen(),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(user: user),
                          ));
                    }
                  } else {
                    _showFailure(context, "Client role error");
                  }
                } else {
                  _showFailure(context, response['message']);
                }
              }
            },
            child: Text('Submit')),
      ],
    );
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password.';
    } else if (value.length < 8) {
      return 'Password must contain more than 8 characters.';
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  Role convertToRole(String sRole) {
    try {
      Role role = Role.values
          .firstWhere((e) => e.toString() == 'Role.' + sRole.toUpperCase());
      return role;
    } catch (_) {
      return null;
    }
  }

  _showPending(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Attempting to login'),
      backgroundColor: Colors.orange,
    ));
  }

  _showSuccess(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Login successful'),
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
