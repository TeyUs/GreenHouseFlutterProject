import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ilk_deneme/GreenHouse.dart';
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ÇDTP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'GreenHouse Control App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = "http://34.107.111.0/";
  final myController = TextEditingController();
  String message = "";
  String userName = "admin";
  String passWord = "123";

  @override
  void initState() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => getMessage());
    //getMessage();
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "GreenHouse Temperature : " + message,
              style: new TextStyle(fontSize: 17.0),
            ),
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 210,
              child: Column(children: <Widget>[
                TextFormField(
                  controller: myController,
                  decoration: InputDecoration(labelText: 'Desired Temperature'),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: sendMessage,
                  child: Text(
                    'Send Temperature',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getMessage() async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$passWord'));
    final response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});

    if (response.statusCode == 200) {
      setState(() {
        //message = response.body.toString();
        message = GreenHouse.fromJson(jsonDecode(response.body))
            .currentTemp
            .toString();
      });
    } else {
      print("Get Metod has a problem. StatusCode : " +
          response.statusCode.toString());
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendMessage() async {
    String text = myController.text;
    var time = DateTime.now().toIso8601String();

    var mybody = json.encode({"desiredTemp": int.parse(text), "date": time});
    //{"desiredTemp": 30, "date": "2021-12-08T15:20:10.814Z"});

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$passWord'));
    final response = await http.post(url + "desired-temp",
        headers: <String, String>{
          'authorization': basicAuth,
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: mybody);

    print("Temp : " +
        text +
        "      StatusCode : " +
        response.statusCode.toString());
  }
}
