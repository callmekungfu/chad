import 'package:flutter/widgets.dart';

import 'models/user.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

@immutable
class ChadAppState {
  final User user;
  ChadAppState({this.user});
}