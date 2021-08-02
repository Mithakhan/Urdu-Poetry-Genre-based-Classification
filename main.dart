
import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url;

  var Data;

  String DataText = 'Prediction will be here';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Urdu Poetry Classification'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                
                onChanged: (value) {
                  url = 'http://127.0.0.1:12345/predict/'+value.toString();
                },
                decoration: InputDecoration(
                    hintText: 'Put your poetry here',
                    suffixIcon: IconButton(
                        onPressed: () async {
                          Data = await getdata(url);
                          print("Data is: "+Data);
                          setState(() {
                            DataText = Data;
                          });
                        },
                        icon: Icon(Icons.search)
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
               ( DataText??'Default value'),
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}