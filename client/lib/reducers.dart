import 'package:client/state.dart';

import 'actions.dart';

ChadAppState chadReducers(ChadAppState prevState, dynamic action) {
  switch (action['type']) {
    case Actions.AUTHENTICATE:
      return ChadAppState(user: action.user);
    default:
      return prevState;
  }
}