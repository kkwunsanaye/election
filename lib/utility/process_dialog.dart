import 'package:flutter/material.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/widget/show_title.dart';

Future<Null> progressDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => WillPopScope(
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 16,
          ),
          ShowTitle(
              title: 'Please Wait few Minus',
              textStyle: MyConstant().h2whiteStyle())
        ],
      )),
      onWillPop: () async {
        return false;
      },
    ),
  );
}
