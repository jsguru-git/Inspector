import 'package:flutter/material.dart';
import 'package:api_app/CountryListView.dart';
import 'package:api_app/location.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Sadeem",
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, accentColor: Color.fromARGB(255, 29, 29, 27)
      ),
        home: CountryList(),
    );
  }
}
