import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test MySQl',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  //TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Record'),
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
                insertRecord();
              },
              child: Text('Submit'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewRecord()));
              },
              child: Text('View'),
            ),
          )
        ],
      ),
    );
  }
 Future<void> insertRecord() async{
  // int number1=int.parse(number.text);

    if(name.text!="" || number.text!=""){
      try{
        String uri="https://stallionseeds.com/myfolder/adddata.php";
        var res=await http.post(Uri.parse(uri), body: {
          "name":name.text,
          "mobile":number.text,
        });
        var responce=jsonDecode(res.body);
        if(responce["Success"]=="true"){
          print("Record Inserted");
          name.text="";
          number.text="";
        }
        else{
          print("Some Issue");
        }
      }catch(e){
        print("Error is$e");
      }
    }
    else{
      print("Please fill all Fields");
    }
  }

}
