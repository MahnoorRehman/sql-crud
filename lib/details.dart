import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:sql_crud/update_record.dart';

class ViewRecord extends StatefulWidget {
  ViewRecord({Key? key}) : super(key: key);

  @override
  State<ViewRecord> createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  List userdata = [];

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App Bar"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        //ctx stands for context
        itemCount: userdata.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    UpdateRecord(name:userdata[index]['name'],mobile:userdata[index]['mobile'])));
              } ,
              leading: Icon(
                CupertinoIcons.heart,
                color: Colors.red,
              ),
              title: Text(userdata[index]['name']),
              subtitle: Text(userdata[index]['mobile']),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                 // print('My ID:' + userdata[index]['id']);
                  if (userdata == null) {
                    print("You dont have data to delete");
                  } else {
                    deleteRecord(userdata[index]['id']);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getData() async {
    var uri = 'https://stallionseeds.com/myfolder/getdata.php';

    userdata.clear();
    // print('Data loading ');
    try {
      var responce = await http.post(Uri.parse(uri));

      // print("My Response: " + responce.body.toString());
      //ya status code hota ha agr server sa coomunication sahe ho ok
      if (responce.statusCode == 200) {
        setState(() {
          userdata = jsonDecode(responce.body);
          // print(userdata);
        });
      }
    } catch (e) {
      print('Error is ' + e.toString());
    }
    // print(json.decode(responce.body));
  }

  Future<void> deleteRecord(String id) async {
    var uri = "https://stallionseeds.com/myfolder/deletedta.php";
    try {
      print('This id: ' + id.toString());
      var res = await http.post(Uri.parse(uri), body: {
        'id': id.toString(),
      });
      var responce = jsonDecode(res.body);
      if (responce["Success"] == "true") {
        print("Record Deleted");
        getData();
      } else {
        print("Record Not Deleted");
      }
      //ya line screen ko refresh kr date ha or pata b ni lagta
      setState(() {});
    } catch (e) {
      print("Error is: $e");
    }
  }
}
