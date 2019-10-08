import 'dart:core';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/global.dart';
import 'package:api_app/CountryListView.dart';

class NewCountry extends StatefulWidget {
  final List <Country> country;
  NewCountry(this.country);
  @override
  _NewCountryState createState() => _NewCountryState(country);
}

class _NewCountryState extends State<NewCountry> {
  List <Country> country;
  int id;
  String name;
  _NewCountryState(this.country);
  final key = GlobalKey<FormState>();

   Map<String, String> headers = {"Content-type": "application/json"};

//  get _CountryListState =>_CountryListState;

  Future <Country> postCountryList( Country item) async{
   http.post(URL.URL_COUNTRY,headers:headers,
       body: json.encode(item.toMap(id))).then((http.Response response){
     print("Response status: ${response.statusCode}");
     print("Response body: ${response.contentLength}");
     print(response.reasonPhrase);
     print(response.request);
     print(item.toMap(id));

   });
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add new Project'),
        ),
        body: SingleChildScrollView(
       child:Form(
         key:key ,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[

          ListTile(
              contentPadding: EdgeInsets.all(15.0),
              title:TextFormField(
          onSaved: (value)=> name= value,
             decoration: InputDecoration(
            labelText: 'Project Name',
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0)
                      )
                  ),
                maxLines: 1,

              )
          ),
             ListTile(
               title: RaisedButton(
                   child: Text('Save'),
                   onPressed: () {
                   this.key.currentState.save();
                     Country country =  new Country( id:id, name: name);
                     postCountryList(country);
                     Navigator.pop(context, country);
                     setState(() {
                       Country;
                     });
                   } ),
             )
           ],
           )
       )
        )
    );
  }
}
