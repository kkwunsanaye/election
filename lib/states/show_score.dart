import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamelection/model/election_model.dart';
import 'package:kamelection/model/otp_model.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/widget/show_rogress.dart';
import 'package:kamelection/widget/show_title.dart';

class ShowScore extends StatefulWidget {
  const ShowScore({Key key}) : super(key: key);

  @override
  _ShowScoreState createState() => _ShowScoreState();
}

class _ShowScoreState extends State<ShowScore> {
  List<ElectionModel> electionModels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Dio().get(MyConstant.apiGetAllCity).then((value) {
      for (var item in json.decode(value.data)) {
        ElectionModel model = ElectionModel.fromMap(item);
        setState(() {
          electionModels.add(model);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.greenBody,
      body: electionModels.length == 0
          ? ShowProgress()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShowTitle(
                    title: 'รายชื่อผู้สมัคร',
                    textStyle: MyConstant().h0Style()),
                buildGridView(),
              ],
            ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        // mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) => Card(
        color: Colors.black12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 40,
              height: 50,
              child: Image.network(
                  '${MyConstant.domain}/election/${electionModels[index].image}'),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 60,
              child: Column(
                children: [
                  ShowTitle(
                    title: electionModels[index].name,
                    textStyle: MyConstant().h2whiteStyle(),
                  ),
                  ShowTitle(
                      title: 'คะแนนที่ได้ = ${electionModels[index].score}',
                      textStyle: MyConstant().h2YellowStyle())
                ],
              ),
            ),
          ],
        ),
      ),
      itemCount: electionModels.length,
    );
  }
}
