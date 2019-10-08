import 'dart:core';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/global.dart';

class NewProject extends StatefulWidget {
  final List <Project> project;
  final int countryID;

  NewProject (this.project, this.countryID);
  @override
  _NewProjectState createState() => _NewProjectState(project, countryID);
}

class _NewProjectState extends State<NewProject> {
  List <Project> project; final int countryID;
  _NewProjectState(this.project,this.countryID);

  int id; String name;
  String city; String orgnazation;
  double latitude ; double longtitude;
  int CountryId;
  TextEditingController priceController = TextEditingController();
  final key = GlobalKey<FormState>();
  Map<String, String> headers = {"Content-type": "application/json"};

  Future <Project> postProjectList( Project item) async{
    http.post(URL.URL_PROJECT ,headers:headers,
        body: json.encode(item.toMap(id))).then((http.Response response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);
     // print(response.body);
      print(item.toMap(id));
      print(json.decode(response.body)['id']);
      item.id = json.decode(response.body)['id'];
      Navigator.pop(context, item);
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
                    contentPadding: EdgeInsets.all(15.0),
                    title:TextFormField(
                      onSaved: (value)=> city= value,
                      decoration: InputDecoration(
                          labelText: 'Enter city',
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
                      onSaved: (value)=> orgnazation= value,
                      decoration: InputDecoration(
                          labelText: 'orgnazation',
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
                onSaved: (value)=> latitude = double.parse(value),
               keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Latitude',
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
                      onSaved: (value)=> longtitude= double.parse(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Longtitude',
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
                      //  print(countryID);
                        this.key.currentState.save();
                        Project projectData =  new Project(id: id, name: name, city: city, orgnazation: orgnazation,
                        latitude: latitude, longtitude: longtitude, CountryId: countryID);
                        postProjectList( projectData);
                      } ),
                )
              ]
          )
          )
      )
    );
  }
}
