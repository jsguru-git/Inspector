import 'package:flutter/material.dart';
import 'package:api_app/Models.dart';
import 'package:api_app/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateCountry extends StatefulWidget {
  final int countryID;
  final String countryName;
  UpdateCountry({Key key, this.countryID, this.countryName}) : super();
  @override
  _UpdateCountryState createState() => _UpdateCountryState(countryID, countryName);
}

class _UpdateCountryState extends State<UpdateCountry> {
  final int countryID;
  final String countryName;

  _UpdateCountryState(this.countryID, this.countryName);
  final key = GlobalKey<FormState>();
 Country country;
  String name;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Map<String, String> headers = {"Content-type": "application/json"};

  Future <Country> UpdateCountryitem ( Country item, int c_id) async{
    http.put(URL.URL_COUNTRY + c_id.toString() ,headers:headers,
        body: json.encode(item.toMapEdit(c_id))).then((http.Response response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);
      print(item.toMapEdit(c_id));

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
                              labelText: 'Country Name',
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
                            Country country =  new Country(id: countryID, name: name);
                           UpdateCountryitem (country,countryID );
                            Navigator.pop(context, country);
                          } ),
                    )
                  ],
                )
            )
        )
    );
  }
}
