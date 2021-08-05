import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kamelection/states/show_score.dart';
import 'package:kamelection/utility/my_constant.dart';

class ShowCheck extends StatefulWidget {
  const ShowCheck({Key key}) : super(key: key);

  @override
  _ShowCheckState createState() => _ShowCheckState();
}

class _ShowCheckState extends State<ShowCheck> {
  int amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readPeople();
  }

  Future<Null> readPeople() async {
    await Dio().get(MyConstant.apiGetAllotp).then((value) {
      var result = json.decode(value.data);
      setState(() {
        amount = result.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.greenBody,
      appBar: AppBar(
        title: amount == null
            ? Text('จำนวนผู้มีสิทธิ์ =  x คน')
            : Text('จำนวนผู้มีสิทธิ์ = $amount คน'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyConstant.yellowlight,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ShowScore(),
    );
  }
}
