import 'package:flutter/material.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/widget/show_logo.dart';
import 'package:kamelection/widget/show_title.dart';

class AfterElection extends StatefulWidget {
  const AfterElection({Key key}) : super(key: key);

  @override
  _AfterElectionState createState() => _AfterElectionState();
}

class _AfterElectionState extends State<AfterElection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: MyConstant.greenBody,
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 150,
            child: ShowLogo(),
          ),
ShowTitle(title: 'รอผลการตรวจนับ', textStyle: MyConstant().h0Style())        ],
      )),
    );
  }
}
