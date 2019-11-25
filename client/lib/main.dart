import 'package:client/reducers.dart';
import 'package:client/screens/employee-hub-view/components/service-list.dart';
import 'package:client/screens/employee-hub-view/employee-hub-view.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/patient-hub-view/components/provider-details.dart';
import 'package:client/screens/patient-hub-view/patient-hub-view.dart';
import 'package:client/screens/service-management/service-management.dart';
import 'package:client/state.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/login/login.dart';
import 'package:client/screens/admin/admin-screen.dart';
import 'package:client/screens/serviceBrowser/service-browser-screen.dart';
import 'package:client/screens/adminHubView/adminHubView.dart';
import 'package:client/screens/providerProfile/providerProfile.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  runApp(ChadApp());
}
class ChadApp extends StatelessWidget {
  final store = new Store<ChadAppState>(
    chadReducers,
    initialState: new ChadAppState(),
    middleware: [LoggingMiddleware.printer()]
  );

  @override
  Widget build(BuildContext context) {
    return 
      StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'CHAD Clinic',
          initialRoute: '/patient',
          routes: <String, WidgetBuilder>{
            "/": (BuildContext context) => Home(),
            "/login": (BuildContext context) => LoginScreen(),
            "/admin/service/form": (BuildContext context) => ServiceManagementForm(),
            "/admin/user": (BuildContext context) => AdminScreen(),
            "/admin/service": (BuildContext context) => ServiceBrowserScreen(),
            "/admin": (BuildContext context) => AdminHubView(),
            "/service-provider": (BuildContext context) => EmployeeHubView(),
            "/service-provider/list": (BuildContext context) => ServiceListWidget(showAll: false, user: null,),
            "/service-provider/form": (BuildContext context) => ProfileScreen(),
            "/patient": (BuildContext context) => PatientHubView(user: null,),
            "/patient/details": (BuildContext context) => ServiceProviderDetailsView(user: null, profile: null,),
          },
        ),
      );
  }
}
