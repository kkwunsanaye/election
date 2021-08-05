import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamelection/model/election_model.dart';
import 'package:kamelection/model/sqlite_model.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/utility/my_test.dart';
import 'package:kamelection/utility/sqlite_helper.dart';
import 'package:kamelection/widget/show_logo.dart';
import 'package:kamelection/widget/show_title.dart';

class AfterElection extends StatefulWidget {
  const AfterElection({Key key}) : super(key: key);

  @override
  _AfterElectionState createState() => _AfterElectionState();
}

class _AfterElectionState extends State<AfterElection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSQLupload();
  }

  Future<Null> checkSQLupload() async {
    await SQLiteHelper().readAllData().then((value) async {
      if (value.length  != 0) {
        List<SQLiteModel> sqliteModels = value;
      // print('จำนวนขนาดของ SQL ==>> ${sqliteModels.length} ');
      for (var item in sqliteModels) {
        // print('### id = ${item.id} | ${item.idOtp} | ${item.choiceChooseId}');
        print('######### choiceChooseId  =>>>> ${item.choiceChooseId}');

        String string = item.choiceChooseId;
        string = string.substring(1, string.length - 1);
        List<String> strings = string.split(',');
        for (var item in strings) {
          String id = item.trim();
          String apiGetScoreWhereId =
              'https://www.androidthai.in.th/election/getElectionWhereId.php?isAdd=true&id=$id';
          await Dio().get(apiGetScoreWhereId).then((value) async {
            for (var item in json.decode(value.data)) {
              ElectionModel electionModel = ElectionModel.fromMap(item);
              String scoreStr = electionModel.score;
              print('######## scoreStr =>>>> $scoreStr');

              int score = int.parse(scoreStr) + 1;

              String apiEditScoreWhereId =
                  'https://www.androidthai.in.th/election/editScoreWhereId.php?isAdd=true&id=$id&score=$score';
              await Dio().get(apiEditScoreWhereId).then((value) {
                print(
                    '####### Edit id ผู้สมัครที่ $id มีค่า Score ===>> $score');
              });
            }
          });
        }

        String path =
            '${MyConstant.domain}/election/editChooseWhereId.php?isAdd=true&id=${item.idOtp}&choiceChooseIds=${item.choiceChooseId}';
        // print('### path api of editChoise ==>> $path');
        await Dio().get(path).then((value) {
          // print('##### Edit Finish #####');
        });
      }
      }
    }).then((value) {
      SQLiteHelper().deleteAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => MyTest().readSQLite(),
        child: Text('SQLLite'),
      ),
      backgroundColor: MyConstant.greenBody,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            child: ShowLogo(),
          ),
          ShowTitle(title: 'รอผลการตรวจนับ', textStyle: MyConstant().h0Style())
        ],
      )),
    );
  }
}
