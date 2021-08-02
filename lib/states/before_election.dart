import 'package:flutter/material.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/widget/show_title.dart';

class BeforeElection extends StatefulWidget {
  const BeforeElection({Key key}) : super(key: key);

  @override
  _BeforeElectionState createState() => _BeforeElectionState();
}

class _BeforeElectionState extends State<BeforeElection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.greenBody,
      body: Center(
        child: ShowTitle(
            title: 'การเลือกตั้ง AAA', textStyle: MyConstant().h1Style()),
      ),
    );
  }
}
