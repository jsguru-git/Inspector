import 'dart:core';
import 'dart:io';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/global.dart';
import 'package:image_picker/image_picker.dart';

class UpdateInspectin extends StatefulWidget {
final  int I_id;
final  String I_name;
final  double I_TunnelWidht;
final  double I_TunnelHeight;
final  double I_LampWidth;
final  double I_LampCircumference;
final  String I_ImageNearby;
final  String I_ImageOverall;
final  String I_SunPath;
final  double I_Latitude;
final  double I_Longtitude;
final  bool I_Status;
final  String I_Sensor;
final  int I_ProjectId;

   UpdateInspectin({this.I_id, this.I_name, this.I_TunnelWidht, this.I_TunnelHeight, this.I_LampWidth, this.I_LampCircumference,
    this.I_ImageNearby, this.I_ImageOverall,this.I_SunPath, this.I_Latitude , this.I_Longtitude ,
     this.I_Status, this.I_Sensor, this.I_ProjectId}) : super();
  @override
  _UpdateInspectinState createState() => _UpdateInspectinState(I_id, I_name, I_TunnelWidht,I_TunnelHeight, I_LampWidth,I_LampCircumference,
     I_ImageNearby, I_ImageOverall ,I_SunPath, I_Latitude, I_Longtitude,I_Status, I_Sensor, I_ProjectId);
}

class _UpdateInspectinState extends State<UpdateInspectin> {
  final  int I_id;
  final  String I_name;
  final  double I_TunnelWidht;
  final  double I_TunnelHeight;
  final  double I_LampWidth;
  final  double I_LampCircumference;
  final  String I_ImageNearby;
  final  String I_ImageOverall;
  final  String I_SunPath;
  final  double I_Latitude;
  final  double I_Longtitude;
  final  bool I_Status;
  final  String I_Sensor;
  final  int I_ProjectId;

  _UpdateInspectinState(this.I_id, this.I_name, this.I_TunnelWidht,this.I_TunnelHeight,this.I_LampWidth, this.I_LampCircumference,
      this.I_ImageNearby, this.I_ImageOverall,this.I_SunPath, this.I_Latitude, this.I_Longtitude,this.I_Status,this.I_Sensor, this.I_ProjectId);
  final key = GlobalKey<FormState>();
  int id;
  String name;
  double TunnelWidht;
  double TunnelHeight;
  double LampWidth;
  double LampCircumference;
  String ImageNearby;
  String ImageOverall;
  String SunPath;
  double Latitude;
  double Longtitude;
  bool Status;
  String Sensor;
  int ProjectId;
  Map<String, String> headers = {"Content-type":  "application/json"};
  bool _autoValidate = false;
  void PickImageNearby() async {
    print('picker is called ');
    var image = await ImagePicker.pickImage(source: ImageSource.camera );
    ImageNearby = image.path;
    print(ImageNearby);
    setState(() {
      ImageNearby;
    });
  }
  void PickImageOverAll() async {
    print('picker is called ');
    var imageo = await ImagePicker.pickImage(source: ImageSource.camera );
    ImageOverall = imageo.path;
    print(ImageOverall);
    setState(() {
      ImageOverall;
    });
  }
  void PickImageSunpath() async {
    print('picker is called ');
    var image = await ImagePicker.pickImage(source: ImageSource.camera );
    SunPath = image.path;
    print(SunPath);
    setState(() {
      SunPath;
    });
  }
  Future <Inspection> UpdateInspectionList(Inspection item) async {
    http.put(URL.URL_INSPECTION , headers: headers,
        body:  json.encode(item.toMapEdit())).then((http.Response response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);
      print(item.toMapEdit());
    });
  }
  void _validateInputs() {
    if (key.currentState.validate()) {
//    If all data are correct then save data to out variables
      key.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Edit"),
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
                                value = I_name;
                                name= value;
                              }
                              else {
                                name = value;
                              }
                            },
                            decoration: InputDecoration(
                                labelText: "Inspection Name",
                                hintText:I_name ,
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
                            onSaved: (value){
                              if (value.isEmpty){
                                value = I_Sensor;
                                Sensor= value;
                              }
                              else{
                                Sensor= value;
                              }
                            },
                            decoration: InputDecoration(
                                labelText:"Sensor name",
                                hintText: I_Sensor,
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
                        title: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color:Color.fromARGB(10, 0, 0, 0),
                              borderRadius:BorderRadius.circular(8.0)
                          ),
                          child: Column( children: <Widget>[
                            Padding( padding: EdgeInsets.only( top: 20)),
                            Text("Tunnel post",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Padding( padding: EdgeInsets.only( bottom: 20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[Padding(padding:EdgeInsets.only(top:30, left: 10),),
                              new Flexible(child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (String val){
                              if (val.length==0){
                              return "Please enter a value";
                              }
                              else{return null; }
                              },
                                autovalidate: _autoValidate,
                                onSaved:( value) {
                                  if (value.isEmpty){
                                    value = I_TunnelWidht.toString();
                                    TunnelWidht = double.parse(value);
                                  }
                                  else{
                                    TunnelWidht = double.parse(value);
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText:"Tunnel width" ,
                                    hintText:I_TunnelWidht.toString() ,
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    )
                                ),
                                maxLines: 1,
                              )),
                              SizedBox(width: 10.0,),
                              Padding(padding:EdgeInsets.only(top: 30, left: 10),),
                              new Flexible(child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (String val){
                                  if(val.length ==0){
                                    return "Please enter a value";
                                  }
                                  else{ return null;}
                                },
                                autovalidate: _autoValidate,
                                onSaved: (value){
                              if (value.isEmpty){
                              value= I_TunnelHeight.toString();
                              TunnelHeight = double.parse(value);
                              }
                              else{
                              TunnelHeight = double.parse(value);
                              }
                              },
                                decoration: InputDecoration(
                                    labelText: "Tunnel Height",
                                    hintText:I_TunnelHeight.toString() ,
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    )
                                ),
                                maxLines: 1,
                              ))
                              ],
                            )
                          ],),
                        ),

                      ),

                      ListTile(
                        contentPadding: EdgeInsets.all(15.0),
                        title: Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color:Color.fromARGB(10, 0, 0, 0),
                              borderRadius:BorderRadius.circular(8.0)
                          ),
                          child: Column( children: <Widget>[
                            Padding( padding: EdgeInsets.only( top: 20)),
                            Text("Lamp Post",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            Padding( padding: EdgeInsets.only( bottom: 20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[Padding(padding:EdgeInsets.only(top:30, left: 10),),
                              new Flexible(child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (String val){
                                  if (val.length==0){
                                    return "Please enter a value";
                                  }
                                  else{return null; }
                                },
                                autovalidate: _autoValidate,
                                onSaved: (value){
                              if (value.isEmpty){
                              value = I_LampWidth.toString();
                              LampWidth = double.parse(value);
                              }
                              else{
                              LampWidth = double.parse(value);
                              }
                              },
                                decoration: InputDecoration(
                                    labelText: "Lamp Width",
                                    hintText:I_LampWidth.toString(),
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    )
                                ),
                                maxLines: 1,
                              )),
                              SizedBox(width: 10.0,),
                              Padding(padding:EdgeInsets.only(top: 30, left: 10),),
                              new Flexible(child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (String val){
                                  if(val.length ==0){
                                    return "Please enter a value";
                                  }
                                  else{ return null;}
                                },
                                autovalidate: _autoValidate,
                                onSaved: (value) {
                                  if (value.isEmpty){
                                    value = I_LampCircumference.toString();
                                    LampCircumference = double.parse(value);
                                  }
                                  else{
                                    LampCircumference = double.parse(value);
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: "Lamp Circumference",
                                    hintText: I_LampCircumference.toString(),
                                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                    border: new OutlineInputBorder(
                                        borderRadius: new BorderRadius.circular(15.0)
                                    )
                                ),
                                maxLines: 1,
                              ))
                              ],
                            )
                          ],),
                        ),

                      ),

                      ListTile(
                        title: Container(
                          height: 470,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(100, 254, 254, 254),
                              borderRadius:BorderRadius.circular(8.0),
                              boxShadow:[
                                BoxShadow(
                                    color:Colors.black12,
                                    offset:Offset(0.0, -2.0),
                                    blurRadius:1.0
                                )
                              ]
                          ),
                          padding: EdgeInsets.all(20.0),
                          child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text("Add image nearby: ", style:  TextStyle(fontWeight: FontWeight.bold),),
                                    Padding(padding:(EdgeInsets.only(left: 70.0)),),
                                    Container(
                                        decoration: BoxDecoration(
                                          color:Color.fromARGB(150, 255, 255, 255),
                                          border: Border.all(color: Colors.black,width: 1),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        height: 90, width: 130,
                                        padding: EdgeInsets.all(2.0),
                                        child: ImageNearby == null?
                                        IconButton(icon: Icon(Icons.broken_image , size: 40,),
                                            onPressed:PickImageNearby
                                        )
                                            :Image.file(File(ImageNearby), fit: BoxFit.fill,)
                                    )
                                  ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.only(top: 170),),
                                      Text("Add image overall: ", style: TextStyle(fontWeight: FontWeight.bold),),
                                      Padding(padding: (EdgeInsets.only(left: 70.0)),),
                                      Container(
                                          decoration: BoxDecoration(
                                            color:Color.fromARGB(150, 255, 255, 255),
                                            border:Border.all(color: Colors.black,width: 1),
                                            borderRadius:BorderRadius.circular(8.0),
                                          ),
                                          height: 90, width: 130,
                                          padding: EdgeInsets.all(2.0),
                                          child: ImageOverall == null?
                                          IconButton(icon: Icon(Icons.broken_image, size: 40,),
                                            onPressed: PickImageOverAll,)
                                              : Image.file(File(ImageOverall), fit: BoxFit.fill,)
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.only(top: 170),),
                                      Text("Add image sunpath:", style: TextStyle(fontWeight: FontWeight.bold),),
                                      Padding(padding: (EdgeInsets.only(left: 50.0)),),
                                      Container(
                                          decoration: BoxDecoration(
                                            color:Color.fromARGB(150, 255, 255, 255),
                                            border:Border.all(color: Colors.black,width: 1),
                                            borderRadius:BorderRadius.circular(8.0),
                                          ),
                                          height: 90, width: 130,
                                          padding: EdgeInsets.all(2.0),
                                          child: SunPath == null?
                                          IconButton(icon: Icon(Icons.broken_image, size: 40,),
                                            onPressed: PickImageSunpath,)
                                              : Image.file(File(SunPath), fit: BoxFit.fill,)
                                      )
                                    ],
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                      ListTile(
                        title: Container(
                          child: CheckboxListTile(
                            title: Text("The sensor has been installed"),
                            value: Status!= false,
                            onChanged: (bool val){
                              setState(() {
                                Status = val ?true :false ;
                              });
                              print(Status.toString());
                            },
                          ),
                        ),
                      ),

                      ListTile(
                          contentPadding: EdgeInsets.all(15.0),
                          title:TextFormField(
                            onSaved: (value)=> Latitude=I_Latitude,
                            decoration: InputDecoration(
                                labelText: I_Latitude.toString(),
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
                            onSaved: (value)=> Longtitude=I_Longtitude,
                            decoration: InputDecoration(
                                labelText: I_Longtitude.toString(),
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
                              print(I_id);
                              Inspection inspectiondata =  new Inspection(id: I_id, name:name, TunnelWidht:TunnelWidht, TunnelHeight: TunnelHeight,
                              LampWidth: LampWidth, LampCircumference: LampCircumference,ImageNearby: I_ImageNearby,Latitude: Latitude,Longtitude: Longtitude,
                                  ImageOverall:I_ImageOverall,SunPath: SunPath, Status: Status, Sensor:Sensor ,ProjectId: I_ProjectId);

                              UpdateInspectionList( inspectiondata);
                              print( "output");
                              // print(postProjectList(projectData));
                              Navigator.pop(context, inspectiondata);

                            } ),
                      )
                    ]
                )
            )
        )
    );
  }
}
