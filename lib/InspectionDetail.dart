import 'dart:core';
import 'dart:io';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_app/global.dart';
import 'package:image_picker/image_picker.dart';

class InspectionDetail extends StatelessWidget {
  final Inspection inspectionList;
  var pic;
  InspectionDetail(this.inspectionList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(inspectionList.name),
      ),
       body: SingleChildScrollView(
         child: Column(
           children: <Widget>[
             Container(
               padding: EdgeInsets.all(5),
               margin:EdgeInsets.all(20),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(6)),
                 color:Colors.grey[200],
               ),
               height: 170,
               child: Column(children: <Widget>[
                 Padding(padding: EdgeInsets.only(bottom: 15)),
                 Text('Lamp post', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                 Padding(padding: EdgeInsets.only(bottom: 5)),
                 Row(children: <Widget>[
                   Padding(padding: EdgeInsets.only(left: 15)),
                   Text('Lamp Width:', style: TextStyle(fontSize: 20)),
                   Padding(padding: EdgeInsets.only(left: 180)),
                   Text(inspectionList.LampWidth.toString(), style:  TextStyle(fontSize: 20)),
                   inspectionList.LampWidth.toString()==null? new Text('No data')
                       : Padding(padding: EdgeInsets.only(bottom: 60)),
                 ],),
                 Row(
                   children: [

                     Padding(padding: EdgeInsets.only(left: 15)),
                     Text('Lamp circumfernce:', style: TextStyle(fontSize: 20)),
                     Padding(padding: EdgeInsets.only(left: 120)),
                     inspectionList.LampCircumference.toString() ==null ? new Text('No data')
                         :Text(inspectionList.LampCircumference.toString(), style: TextStyle(fontSize: 20)),

                   ],
                 )
               ],),
             ),

             Container(
               padding:EdgeInsets.all(5) ,
               margin: EdgeInsets.all(20),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(6)),
                   color: Colors.grey[200]
               ),
               height: 170,


               child: Column(children:[
                 Padding(padding: EdgeInsets.only(bottom: 15)),
                 Text('Tunnel post', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                 Padding(padding: EdgeInsets.only(bottom: 5)),
                 Row(
                   children:[
                     Padding(padding: EdgeInsets.only(left: 15)),
                     Text('Tunnel Width:', style: TextStyle(fontSize: 20)),
                     Padding(padding: EdgeInsets.only(left: 150)),
                     inspectionList.TunnelWidht == null ?
                     new Text('No data') :Padding(padding: EdgeInsets.only(bottom: 60)),
                      Text(inspectionList.TunnelWidht.toString(), style:  TextStyle(fontSize: 20)),


                   ],
                 ),
                 Row(
                   children: [
                     Padding(padding: EdgeInsets.only(left: 15)),
                     Text('Tunnel height:', style: TextStyle(fontSize: 20)),
                     Padding(padding: EdgeInsets.only(left: 150)),
                     inspectionList.TunnelHeight == null ?
                     new Text('No data')
                      :Text(inspectionList.TunnelHeight.toString(), style: TextStyle(fontSize: 20)),
                   ],
                 )
               ]),
             ),
             Container(
               margin: EdgeInsets.all(20),
               height: 200,
               child: inspectionList.ImageNearby==null? new Text('no image'): Image.file(new File(inspectionList.ImageNearby)),
             ),
             Container(
               margin: EdgeInsets.all(20),
               height: 200,
               child: inspectionList.ImageOverall==null? new Text('no image'): Image.file(new File(inspectionList.ImageOverall)),
             ),
             Container(
               margin: EdgeInsets.all(20),
               height: 200,
               child: inspectionList.SunPath==null? new Text('no image'): Image.file(new File(inspectionList.SunPath)),
             ),
             Container(
               padding: EdgeInsets.all(5),
               margin: EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.grey[200],
                 borderRadius: BorderRadius.all(Radius.circular(6)),
               ),
               height: 50,
               child: Row(
                 children:[
                   Padding(padding: EdgeInsets.only(bottom: 15)),
                   Text('Sensor' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   Row(
                     children:[
                       Padding(padding: EdgeInsets.only(left: 200)),
                       Text(inspectionList.Sensor, style: TextStyle(fontSize: 16),)
                     ],
                   )
                 ],
               ),
             ),
             Container(
               padding: EdgeInsets.all(5),
               margin: EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.grey[200],
                 borderRadius: BorderRadius.all(Radius.circular(6)),
               ),
               height: 50,
               child: Row(
                 children:[
                   Padding(padding: EdgeInsets.only(bottom: 15)),
                   Text('Status' , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                   Row(
                     children:[
                       Padding(padding: EdgeInsets.only(left: 200)),
                       Text(inspectionList.Status.toString(), style: TextStyle(fontSize: 16),)
                     ],
                   )
                 ],
               ),


             ),
           ],
         ),
       )
      //Container(
        // margin: EdgeInsets.all(20),
        // height: 200,
        // child:
        //   inspectionList.SunPath==null? new Text('no image'):
        //  Image.file(new File(inspectionList.SunPath)),
        // )
       );
  }
}
