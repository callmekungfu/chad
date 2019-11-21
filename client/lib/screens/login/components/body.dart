import 'package:client/actions.dart' as ChadActions;
import 'package:client/screens/admin/admin-screen.dart';
import 'package:client/screens/adminHubView/adminHubView.dart';
import 'package:client/screens/employee-hub-view/employee-hub-view.dart';
import 'package:client/screens/providerProfile/providerProfile.dart';
import 'package:client/state.dart';
import 'package:flutter/material.dart';
import 'package:client/models/credential.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/models/user.dart';
import 'package:client/models/role.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Body extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Body> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  User _user;
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
            decoration: new InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            maxLength: 32,
            validator: validateEmail,
            onSaved: (val) => setState(() => _credential.userName = val)),
        new TextFormField(
            decoration: new InputDecoration(labelText: 'Password'),
            maxLength: 32,
            obscureText: true,
            validator: validatePassword,
            onSaved: (val) => setState(() => _credential.password = val)),
        new SizedBox(height: 25.0),
        StoreConnector<ChadAppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch({
              'type': ChadActions.Actions.AUTHENTICATE,
              'user': _user,
            });
          },
          builder: (context, callback) {
          return SizedBox(
            child: RaisedButton(
              onPressed: () async {
                final form = _key.currentState;
                if (form.validate()) {
                  form.save();
                  _showPending(context);
                  Map<String, dynamic> response = await _credential.login();
                  if (response['statusCode'] == 200) {
                    Role role = convertToRole(response['user']['role']);
                    if (role != null) {
                      _showSuccess(context);
                      User user = new User();
                      user.firstName = response['user']['firstName'];
                      user.lastName = response['user']['lastName'];
                      user.provider = response['user']['provider'];
                      user.userName = response['user']['userName'];
                      user.role = role;
                      setState(() {
                        _user = user;
                        callback;
                      });
                      if (user.role == Role.ADMINISTRATOR) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminHubView(),
                          )
                        );
                      } else {
                        if (user.provider == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(user: user,)
                            )
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmployeeHubView(user: user,)
                            )
                          );
                        }
                      }
                    } else {
                      _showFailure(context, "Client role error");
                    }
                  } else {
                    _showFailure(context, response['message']);
                  }
                }
              },
              color: Colors.blue,
              child: Text('Login', style: TextStyle(color: Colors.white))
            ),
            width: double.infinity,
            height: 45,
          );
          },
        )
        
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
