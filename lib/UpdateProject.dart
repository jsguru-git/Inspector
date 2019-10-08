import 'dart:core';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/global.dart';

class UpdateProject extends StatefulWidget {
  final int P_id;
  final String p_name;
  final String p_city;
  final String p_orgnazation;
  final double p_latitude;
  final double p_longtitude;
  final int Countryid;

  UpdateProject({Key key, this.P_id, this.p_name, this.p_city, this.p_orgnazation, this.p_latitude, this.p_longtitude, this.Countryid}) : super();

  @override
  _UpdateProjectState createState() => _UpdateProjectState(P_id,p_name, p_city,p_orgnazation, p_latitude,p_longtitude, Countryid );
}

class _UpdateProjectState extends State<UpdateProject> {
  final int P_id;
  final String p_name;
  final String p_city;
  final String p_orgnazation;
  final double p_latitude;
  final double p_longtitude;
  final int Countryid;
  _UpdateProjectState(this.P_id, this.p_name, this.p_city, this.p_orgnazation, this.p_latitude, this.p_longtitude, this.Countryid);

  final key = GlobalKey<FormState>();
  int id;
  String name;
  String city;
  String orgnazation;
  double latitude;
  double longtitude;
  int CountryId;
  Map<String, String> headers = {"Content-type":  "application/json"};

  Future <Project> UpdateProjectList(Project item, int p_id) async {
    http.put(URL.URL_PROJECT+p_id.toString() , headers: headers,
        body:  json.encode(item.toMapEdit(id))).then((http.Response response) {
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
          title: Text("Add new project"),
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
                            onSaved:( value){
                              if (value.isEmpty){
                                 value = p_name;
                                 name= value;
                              }
                              else {
                              name = value;
                              }
                               },
                            decoration: InputDecoration(
                                labelText: p_name,
                                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0)
                                )
                            ),
                            maxLines: 1,

                          )
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(15.0),
                          title:TextFormField(
                            onSaved:( value){
                              if (value.isEmpty){
                                value= p_city;
                                city = value;
                              }
                              else{
                                city= value;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: p_city,
                                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0)
                                )
                            ),
                            maxLines: 1,

                          )
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(15.0),
                          title:TextFormField(
                            onSaved:( value){
                              if (value.isEmpty){
                                value = p_orgnazation; orgnazation= value;
                              }
                              else{
                                orgnazation= value;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: p_orgnazation,
                                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(15.0)
                                )
                            ),
                            maxLines: 1,

                          )
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(15.0),
                          title:TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved:( value) {
                              if (value.isEmpty){
                                value = p_latitude.toString();
                                latitude = double.parse(value);
                              }
                              else{
                              latitude = double.parse(value);
                              }
                            },

                           decoration: InputDecoration(
                               labelText:p_latitude.toString(),
                               labelStyle: TextStyle(fontWeight: FontWeight.bold),
                               border: new OutlineInputBorder(
                                   borderRadius: new BorderRadius.circular(15.0)
                               )
                           ),
                           maxLines: 1,

                          )
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(15.0),
                          title:TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved:( value) {
                          if (value.isEmpty){
                          value = p_longtitude.toString();
                          longtitude = double.parse(value);
                          }
                          else{
                            longtitude = double.parse(value);
                          }
                          },
                            decoration: InputDecoration(
                                labelText: p_longtitude.toString(),
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
                              print(P_id);
                              this.key.currentState.save();
                              Project projectData =  new Project(id: P_id, name: name, city: city, orgnazation: orgnazation,
                                  latitude: latitude, longtitude: longtitude, CountryId:Countryid );
                              UpdateProjectList( projectData, P_id);
                              print( "output");
                              // print(postProjectList(projectData));
                              Navigator.pop(context, projectData);

                            } ),
                      )
                    ]
                )
            )
        )
    );
  }
}
