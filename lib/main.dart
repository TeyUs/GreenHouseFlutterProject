import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  //final String url = "http://34.107.113.203:8080/";
  final String url = "https://jsonplaceholder.typicode.com/albums/1";
  final myController = TextEditingController();
  String message = "";

  @override
  void initState() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => getMessage());
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
            /*RaisedButton(
              onPressed: getMessage,
              child: Text('Get Temperature', style: TextStyle(fontSize: 20)),
            ),*/
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
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        message = response.body.toString();
        //message = GreenHouse.fromJson(jsonDecode(response.body)).toString();
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> sendMessage() async {
    String text = myController.text;
    print(text);
    final response = await http.put(url + "set-desired-temp", body: text);
    print(response.statusCode);
  }
}
