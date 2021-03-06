import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamelection/model/eletiondate_model.dart';
import 'package:kamelection/model/show_result_model.dart';
import 'package:kamelection/provider/amount_provider.dart';
import 'package:kamelection/states/admin_controller.dart';
import 'package:kamelection/states/after_election.dart';
import 'package:kamelection/states/authen_admin.dart';
import 'package:kamelection/states/authen_landscape.dart';
import 'package:kamelection/states/before_election.dart';
import 'package:kamelection/states/show_check.dart';
import 'package:kamelection/states/show_election_result.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:provider/provider.dart';

final Map<String, WidgetBuilder> map = {
  '/authenLandscape': (BuildContext context) => AuthenLandScape(),
  '/showElectionResult': (BuildContext context) => ShowElectionResult(),
  '/beforeElection': (BuildContext context) => BeforeElection(),
  '/afterElecttion': (BuildContext context) => AfterElection(),
  '/showCheck': (BuildContext context) => ShowCheck(),
  '/authenAdmin': (BuildContext context) => AuthenAdmin(),
  '/adminController': (BuildContext context) => AdminController(),
};

String initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Dio().get(MyConstant.apiGetAllElectionDate).then((value) async {
    for (var item in json.decode(value.data)) {
      ElectionDateModel model = ElectionDateModel.fromMap(item);
      DateTime nowDateTime = DateTime.now();
      DateTime electionStartDataTime = DateTime(
        int.parse(model.year),
        int.parse(model.month),
        int.parse(model.day),
        8,
        0,
      );
      DateTime electionEndDataTime = DateTime(
        int.parse(model.year),
        int.parse(model.month),
        int.parse(model.day),
        int.parse(model.hour),
        int.parse(model.minus),
      );
      if (nowDateTime.isAfter(electionStartDataTime)) {
        if (nowDateTime.isBefore(electionEndDataTime)) {
          //???????????????????????????????????????
          initialRoute = MyConstant.routeAutenLandscape;
          runApp(MyApp());
        } else {
          //??????????????????????????????????????????????????? ??????????????????????????????

          await Dio().get(MyConstant.apiGettShowElectio).then((value) {
            print('######### value  =>>> $value');
            for (var item in json.decode(value.data)) {
              ShowResultModel model = ShowResultModel.fromMap(item);
              if (model.showElection == 'true') {
                initialRoute = MyConstant.routeShowElectionResult;
                runApp(MyApp());
              } else {
                initialRoute = MyConstant.routeAfterElection;
                runApp(MyApp());
              }
            }
          });
        }
      } else {
        //??????????????????????????????????????????????????????
        initialRoute = MyConstant.routeBeforeElection;
        runApp(MyApp());
      }
    }
  });
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
