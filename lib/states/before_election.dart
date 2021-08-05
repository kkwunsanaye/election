import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamelection/model/eletiondate_model.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/widget/show_logo.dart';
import 'package:kamelection/widget/show_rogress.dart';
import 'package:kamelection/widget/show_title.dart';

class BeforeElection extends StatefulWidget {
  const BeforeElection({Key key}) : super(key: key);

  @override
  _BeforeElectionState createState() => _BeforeElectionState();
}

class _BeforeElectionState extends State<BeforeElection> {
  ElectionDateModel electionDateModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readElectionDate();
  }

  Future<Null> readElectionDate() async {
    await Dio().get(MyConstant.apiGetAllElectionDate).then((value) {
      print('value = $value');
      for (var item in json.decode(value.data)) {
        setState(() {
          electionDateModel = ElectionDateModel.fromMap(item);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeShowCheck),
          child: ShowTitle(
              title: 'Check', textStyle: MyConstant().h2YellowStyle())),
      backgroundColor: MyConstant.greenBody,
      body: Center(
        child: electionDateModel == null ? ShowProgress() : buildContent(),
      ),
    );
  }

  Column buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          child: ShowLogo(),
        ),
        ShowTitle(
          title: electionDateModel.name,
          textStyle: MyConstant().h0Style(),
        ),
        SizedBox(
          height: 16,
        ),
        ShowTitle(
            title:
                '8.00 - ${electionDateModel.hour} : ${electionDateModel.minus}      ${electionDateModel.day}  / ${electionDateModel.month} / ${electionDateModel.year}',
            textStyle: MyConstant().h1whiteStyle())
      ],
    );
  }
}
