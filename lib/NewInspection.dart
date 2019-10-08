import 'dart:core';
import 'dart:io';
import 'package:api_app/Models.dart';
import 'package:api_app/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewInspection extends StatefulWidget {
  final List<Inspection> inspection;
  final int projectId;
  NewInspection(this.inspection, this.projectId);
  @override
  _NewInspectionState createState() => _NewInspectionState(inspection, projectId);
}

class _NewInspectionState extends State<NewInspection> {
  List <Inspection> inspection; final int projectId;
  _NewInspectionState(this.inspection, this.projectId);
  int id; String name;
  double TunnelWidht; double TunnelHeight;
  double LampWidth; double LampCircumference;
   String ImageNearby; String ImageOverall;
  String SunPath; double Latitude;
  double Longtitude; bool Status;
  String Sensor;
  final key = GlobalKey<FormState>();
  GoogleMapController mycontroller;
  bool _isEnabled = true;
  bool _isEnabledd = true;
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
  void loc() async{
    Position position =await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      mycontroller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(position.latitude, position.longitude),
              zoom: 16.0)
      ));
      Latitude = position.latitude;
      Longtitude = position.longitude;
      print (Latitude); print(Longtitude);
    });
  }

  Map<String, String> headers = {"Content-type": "application/json"};

  Future <Inspection> postInspectionList( Inspection item) async{
    http.post(URL.URL_INSPECTION ,headers:headers,
        body: json.encode(item.toMap(id))).then((http.Response response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);
      print(response.body);
      print(item.toMap(id));

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
                                labelText: 'Inspection Name',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            autovalidate: _autoValidate,
                            validator: (String val){
                              if (val.length ==0){
                                return "Please enter a name";
                              }
                              else{return null;}
                            },
                            maxLines: 1,

                          )
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(15.0),
                          title:TextFormField(
                            onSaved: (value)=> Sensor= value,
                            decoration: InputDecoration(
                                labelText: 'Sensor Name',
                                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            autovalidate: _autoValidate,
                            validator: (String val){
                              if (val.length ==0){
                                return "Please enter a name";
                              }
                              else{return null;}
                            },
                            maxLines: 1,

                          )
                      ),

                      ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title:Container(
                            height:250 ,
                            decoration: BoxDecoration(
                              color:Color.fromARGB(10, 0, 0, 0),
                              borderRadius:BorderRadius.circular(8.0)
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                RaisedButton.icon(
                                onPressed: () => setState(() => _isEnabledd = !_isEnabledd),
                                 label: Text(_isEnabledd ? "Enables" : "Disables"),
                                  icon: Icon(_isEnabledd?  Icons.check_circle :Icons.clear),
                                 color: _isEnabledd ? Colors.green :Colors.grey,
                                ),
                                  ],
                                ),
                                Padding( padding: EdgeInsets.only( top: 20),),
                                Text("Tunnel post:",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Padding( padding: EdgeInsets.only( bottom: 20),),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(padding:EdgeInsets.only(top:30, left: 10),),
                                    new Flexible(child: TextFormField(
                                      keyboardType: TextInputType.number,

                                      autovalidate: _autoValidate,
                                      onSaved: (value){
                                        if(value.isEmpty){
                                        value= 0.toString();
                                        TunnelWidht = double.parse(value);
                                        }
                                        else{
                                        TunnelWidht= double.parse(value);}},
                                      decoration: InputDecoration(
                                        labelText: 'Tunnel Widht',
                                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      maxLines: 1,
                                      enabled: _isEnabledd,
                                    )),
                                    SizedBox(width: 10.0,),
                                    Padding(padding:EdgeInsets.only(top: 30, left: 10),),
                                    new Flexible(child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      autovalidate: _autoValidate,
                                      onSaved: (value){
                                       if(value.isEmpty){
                                       value= 0.toString();
                                       TunnelHeight = double.parse(value);
                                       }
                                       else{
                                       TunnelHeight= double.parse(value);}},
                                      decoration: InputDecoration(
                                        labelText: 'TunnelHeight',
                                        labelStyle: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      maxLines: 1,
                                      enabled: _isEnabledd,
                                    ))
                                  ],
                                )
                              ],
                            ),
                          )

                      ),
                      ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title:Container(
                            height:250 ,
                            decoration: BoxDecoration(
                                color:Color.fromARGB(10, 0, 0, 0),
                                borderRadius:BorderRadius.circular(8.0)
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        RaisedButton.icon(

                                          onPressed: () => setState(() => _isEnabled = !_isEnabled),
                                          label: Text(_isEnabled ? "Enables" : "Disables"),
                                          icon: Icon(_isEnabled?  Icons.check_circle :Icons.clear),
                                          color: _isEnabled ? Colors.green :Colors.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding( padding: EdgeInsets.only( top: 20),),
                                Text("Lamp post:",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                Padding( padding: EdgeInsets.only( bottom: 20),),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(padding:EdgeInsets.only(top:30, left: 10),),
                                    new Flexible(child: TextFormField(
                                      keyboardType: TextInputType.number,

                                      onSaved: (value){
                                        if(value.isEmpty){
                                          value= 0.toString();
                                          LampWidth = double.parse(value);
                                        }
                                        else{
                                        LampWidth= double.parse(value);}},
                                      decoration: InputDecoration(
                                        labelText: "Lamp Width",
                                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      maxLines: 1,
                                      enabled: _isEnabled,
                                    )),
                                    SizedBox(width: 10.0,),
                                    Padding(padding:EdgeInsets.only(top: 30, left: 10),),
                                    new Flexible(child: TextFormField(
                                      keyboardType: TextInputType.number,
                                     // validator: (String val){
                                     //   if(val.length ==0){
                                     //     return "Please enter a value";
                                     //   }
                                     //   else{ return null;}
                                     // },
                                     // autovalidate: _autoValidate,
                                      onSaved: (value) {
                                        if (value.isEmpty){
                                          value = 0.toString();
                                          LampCircumference = double.parse(value);
                                        }
                                        else{
                                        LampCircumference = double.parse(value);}
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Lamp Circumference',
                                          labelStyle: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      maxLines: 1,
                                      enabled: _isEnabled,
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          )
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
                                        onPressed: PickImageNearby,
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
                          title: Container(
                            height: 100,
                            child: Stack(
                              children :[
                            GoogleMap(
                                initialCameraPosition: CameraPosition(
                                target: LatLng(21.4858, 39.1925),
                            zoom: 10.0,
                          ),
                            ),
                                Positioned(
                                  top:30,
                                  right: 15,
                                  left: 15,
                                  child: Container(
                                      height: 50.0,
                                      width: double.infinity,
                                      child:  IconButton(
                                          icon: Icon(Icons.location_on),
                                          onPressed: (){
                                            Navigator.push(context, 
                                            MaterialPageRoute(builder: (BuildContext context)=> Getlocation()
                                            ),);
                                            },
                                          iconSize: 50.0)
                                  ),
                                )
                              ]
                            ),
                          ),
                      ),

                      ListTile(
                        title: RaisedButton(
                            child: Text('Save'),
                            onPressed: () {
                              _validateInputs();
                              this.key.currentState.save();
                              Inspection inspectionData =  new Inspection(id: id, name:name, TunnelWidht:TunnelWidht, TunnelHeight: TunnelHeight
                              ,LampWidth: LampWidth, LampCircumference: LampCircumference, ImageNearby: ImageNearby.toString(), ImageOverall:ImageOverall.toString(),
                              SunPath: SunPath.toString(), Latitude: 54, Longtitude: 45, Status:Status,Sensor: Sensor, ProjectId: projectId);
                              postInspectionList( inspectionData);
                              print( "output");
                              // print(postProjectList(projectData));
                              Navigator.pop(context, inspectionData);

                            } ),
                      ),
                    ]
                )
            )
        )
    );
  }
}
