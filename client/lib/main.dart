import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:client/blocprovs/example-block-prov.dart';
import 'package:client/blocs/example-bloc.dart';
import 'package:client/theme/style.dart';
import 'package:client/screens/login/login.dart';
import 'package:client/screens/example2/examplescreen2.dart';

void main() {
  runApp(ExampleApp());
}
class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExampleProvider(
      bloc: ExampleBloc(),
      child: MaterialApp(
        title: 'ExampleApp',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => LoginScreen(),
          "/ExScreen2": (BuildContext context) => ExScreen2(),
        },
      ),
    );
  }
}
