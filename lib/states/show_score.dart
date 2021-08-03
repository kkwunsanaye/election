import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamelection/utility/my_constant.dart';

class ShowScore extends StatefulWidget {
  const ShowScore({Key key}) : super(key: key);

  @override
  _ShowScoreState createState() => _ShowScoreState();
}

class _ShowScoreState extends State<ShowScore> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Dio().get(MyConstant.apiGetAllCity).then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.greenBody,
      body: Stack(
        children: [
          buildBackButton(context),
          Positioned(left: 50, top: 75, child: Text('ShowScore')),
        ],
      ),
    );
  }

  Positioned buildBackButton(BuildContext context) {
    return Positioned(
        left: 50,
        top: 25,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyConstant.yellowlight,
          ),
          onPressed: () => Navigator.pop(context),
        ));
  }
}
