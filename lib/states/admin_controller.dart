import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kamelection/model/listpeople_model.dart';
import 'package:kamelection/model/otp_model.dart';
import 'package:kamelection/utility/dialog.dart';
import 'package:kamelection/utility/my_constant.dart';
import 'package:kamelection/utility/process_dialog.dart';
import 'package:kamelection/widget/show_logo.dart';
import 'package:kamelection/widget/show_rogress.dart';
import 'package:kamelection/widget/show_title.dart';
import 'package:path_provider/path_provider.dart';

class AdminController extends StatefulWidget {
  const AdminController({Key key}) : super(key: key);

  @override
  _AdminControllerState createState() => _AdminControllerState();
}

class _AdminControllerState extends State<AdminController> {
  List<OtpModel> otpModels = [];
  bool load = true;
  bool haveData; // true ==> Have Data
  List<ListPeopleModel> listPeoPleModels = [];
  List<Widget> widgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readDataOtp();
    readListPeople();
  }

  Future<Null> readListPeople() async {
    String urlApi =
        'https://www.androidthai.in.th/election/getAllListPeople.php';
    int i = 0;
    await Dio().get(urlApi).then((value) {
      for (var item in json.decode(value.data)) {
        ListPeopleModel model = ListPeopleModel.fromMap(item);
        listPeoPleModels.add(model);
        print('##### name ===>>> ${model.name} ');
        widgets.add(createWidget(model, i));
        i++;
      }
    });
  }

  Widget createWidget(ListPeopleModel model, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ShowTitle(title: model.name, textStyle: MyConstant().h2Style()),
        IconButton(
            icon: Icon(
              Icons.cloud_download,
              color: Colors.white,
            ),
            onPressed: () {
              String urlAPI =
                  'https://www.androidthai.in.th/election/data${listPeoPleModels[index].nameFile}';
              print('###### urlAPI ===>> $urlAPI');
              processDownload(urlAPI);
              Navigator.pop(context);
            })
      ],
    );
  }

  Future<Null> readDataOtp() async {
    if (otpModels.length != 0) {
      otpModels.clear();
    }
    String urlAPI = MyConstant.apiGetAllotp;
    await Dio().get(urlAPI).then((value) {
      print('####### value ====>>> $value');
      if (value.toString() == 'null') {
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        for (var item in json.decode(value.data)) {
          OtpModel model = OtpModel.fromMap(item);
          setState(() {
            load = false;
            haveData = true;
            otpModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.greenBody,
      appBar: AppBar(
        title: Text('Admin Controller'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeBeforeElection, (route) => false),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    if (otpModels.length != 0) {
                      normalDialog(context, 'Have Data',
                          'Please Clear Data Before Inseart New Data');
                    } else {
                      showListPeople();
                    } //end if
                  },
                  child: Text('Insert'),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red.shade600),
                  onPressed: () => processTruncate(),
                  child: Text('Clear'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: load
          ? ShowProgress()
          : haveData
              ? ListView.builder(
                  itemCount: otpModels.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ShowTitle(
                          title: otpModels[index].name,
                          textStyle: MyConstant().h2whiteStyle(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ShowTitle(
                          title: otpModels[index].otp,
                          textStyle: MyConstant().h2whiteStyle(),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: ShowTitle(
                      title: 'ยังไม่มีข้อมูล',
                      textStyle: MyConstant().h1whiteStyle()),
                ),
    );
  }

  Future<Null> processTruncate() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyConstant.greenBody,
        title: ListTile(
          leading: ShowLogo(),
          title: ShowTitle(
              title: 'คุณต้องการ clear ข้อมูลทั้งหมดใช่ไหม',
              textStyle: MyConstant().h2whiteStyle()),
          subtitle: ShowTitle(
              title: 'ข้อมูลจะถูกลบทิ้งอย่างถาวร ให้มั่นใจว่าจะ Clear',
              textStyle: MyConstant().h2whiteStyle()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              String urlAPItruncate =
                  'https://www.androidthai.in.th/election/truncateOtp.php';
              await Dio().get(urlAPItruncate).then((value) => readDataOtp());
            },
            child: ShowTitle(
              title: 'Clear',
              textStyle: MyConstant().h2whiteStyle(),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: ShowTitle(
              title: 'Cancel',
              textStyle: MyConstant().h2whiteStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> processInsert(File file) async {
    progressDialog(context);

    var bytes = await file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<String> nameSheets = [];
    for (var item in excel.tables.keys) {
      nameSheets.add(item);
    }

    var maxCol = excel.tables[nameSheets[0]].maxCols;
    var maxRow = excel.tables[nameSheets[0]].maxRows;
    print('###### nameSheets ==>> $nameSheets');
    print('###### maxCol ==>> $maxCol, maxRow ==>> $maxRow');

    int amountRecord = 0;

    for (var item in excel.tables[nameSheets[0]].rows) {
      amountRecord++;
      print('######## item = $item');

      List<dynamic> datas = item;
      String name = '${datas[0]} ${datas[1]} ${datas[2]}';
      String otp = Random().nextInt(1000000).toString();
      String amount = '6';
      String urlAPI =
          'https://www.androidthai.in.th/election/insertOtp.php?isAdd=true&name=$name&otp=$otp&amount=$amount';
      await Dio().get(urlAPI).then((value) {
        if (amountRecord >= maxRow) {
          print('######## end of Data ');
          Navigator.pop(context);
          readDataOtp();
        }
      });
    }
  }

  Future<Null> processDownload(String urlAPI) async {
    // String urlDownload =
    //     'https://www.androidthai.in.th/election/data/test66.xlsx';
    // print('urlDownload ==>> $urlDownload');

    try {
      var tempDir = await getTemporaryDirectory();
      String savePath = tempDir.path + '/data.xlsx';
      print('####### savePath ==> $savePath');

      await Dio().download(urlAPI, savePath).then(
        (value) {
          print('Success Download');
          File file = File(savePath);
          processInsert(file);
        },
      );
    } catch (e) {
      print('error Download ==> ${e.toString()}');
    }
  }

  Future<Null> showListPeople() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyConstant.greenDark,
        title: ShowTitle(
            title: 'Please Choose Name',
            textStyle: MyConstant().h1whiteStyle()),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: widgets,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: ShowTitle(
              title: 'Cancel',
              textStyle: MyConstant().h2YellowStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
