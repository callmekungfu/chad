import 'package:flutter/widgets.dart';

import 'models/user.dart';

@immutable
class ChadAppState {
  final User user;
  ChadAppState({this.user});
}