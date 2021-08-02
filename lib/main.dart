import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamelection/provider/amount_provider.dart';
import 'package:kamelection/states/authen_landscape.dart';
import 'package:kamelection/states/before_election.dart';
import 'package:kamelection/states/show_result.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:provider/provider.dart';

final Map<String, WidgetBuilder> map = {
  '/authenLandscape': (BuildContext context) => AuthenLandScape(),
  '/showResult': (BuildContext context) => ShowReslut(),
  '/beforeElection':(BuildContext context)=>BeforeElection(),
};

String initialRoute;

void main() {
  initialRoute = MyConstant.routeBeforeElection;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return AmountProvider();
          },
        ),
      ],
      child: MaterialApp(
        routes: map,
        initialRoute: initialRoute,
        theme: ThemeData(primaryColor: Colors.green.shade900),
      ),
    );
  }
}
