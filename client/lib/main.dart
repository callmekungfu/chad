import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/blocprovs/example-block-prov.dart';
import 'package:client/blocs/example-bloc.dart';
import 'package:client/theme/style.dart';
import 'package:client/screens/example1/examplescreen1.dart';
import 'package:client/screens/example2/examplescreen2.dart';
import 'package:client/screens/admin/admin-screen.dart';

void main() {
  runApp(ExampleApp());
}
class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleProvider(
      child: MaterialApp(
        title: 'Client',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => AdminScreen(),
          "/ExScreen2": (BuildContext context) => ExScreen2(),
          "/admin": (BuildContext context) => AdminScreen(),
        },
      ),
    );
  }
}
