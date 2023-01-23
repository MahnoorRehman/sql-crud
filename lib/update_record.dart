import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateRecord extends StatefulWidget {
  String name;
  String mobile;

  UpdateRecord({Key? key, required this.name, required this.mobile})
      : super(key: key);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    number.text = widget.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Record'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter the Name'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: number,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Enter Number'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                updateRecord();
              },
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateRecord() async {
   // userdata.clear();
    try {
      String uri = "https://stallionseeds.com/myfolder/editdata.php";
      var res = await http.post(Uri.parse(uri),
          body: {
        "name":name.text,
        "mobile":number.text
          });
      var response= jsonDecode(res.body);
      if (response["Success"] == "true") {
        print("Record Updated Successfully");
        name.text="";
        number.text="";

      } else {
        print("Record Not Updated");
      }
    } catch (e) {
      print("Error is: $e");
    }
  }
}
