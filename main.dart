import 'package:flutter/material.dart';
import 'API.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<Poetry>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Urdu Poetry Classification')),
            ),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child:
                  (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
            )));
  }

  Column buildColumn() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                hintText: 'Put your poetry here',
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _futureAlbum =
                            makeprediction(_controller.text.toString());
                      });
                    },
                    icon: Icon(Icons.search))),
          ),
        ),
      ],
    );
  }

  FutureBuilder<Poetry> buildFutureBuilder() {
    return FutureBuilder<Poetry>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.label);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
