import 'dart:convert';
import 'dart:io';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:api_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:api_app/NewInspection.dart';
import 'package:api_app/UpdateInspection.dart';
import 'package:api_app/InspectionDetail.dart';

class InspectionListView extends StatefulWidget {

  final int projectID;
  final String country, city;

  InspectionListView({this.projectID, this.country, this.city}): super();
  @override
  _InspectionListViewState createState() => _InspectionListViewState(projectID, country, city);
}

class _InspectionListViewState extends State<InspectionListView> {

  int projectID;
  String country, city;
  List<Inspection> inspectionList = List<Inspection>();
  List <Inspection> _search =[];
  _InspectionListViewState(this.projectID, this.country, this.city);

  final GlobalKey <ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, String> headers = {"Content-type": "application/json"};

  void getInspectionList(int pro_id) {
    http.get(URL.URL_INSPECTION + pro_id.toString()).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        inspectionList = list.map((model) => Inspection.fromJson(model)).toList();
        print(response.body);
       print(response.request);
      });
    });
  }
  void DeleteInspection ( List <Inspection> item, int pro_id ){
    http.delete(URL.URL_INSPECTION+ pro_id.toString(), headers: headers).then((http.Response response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);
    });
  }

  void _selfRefresh() {
    getInspectionList(this.projectID);
  }

  @override
  void initState() {
    super.initState();
    getInspectionList(this.projectID);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 10.0,
        title: new Padding(padding: EdgeInsets.only(left: 70.0),
          child: Text('Inspection List'),
        ),
          actions: <Widget>[
            IconButton(
              icon: AddInspection(inspectionList, projectID),
            )
          ]
      ),
      body:Container(
        child: inspectionList.length ==0 ?
        Center(
          child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 200),),
              Text("No Inspections " , style: TextStyle(fontWeight: FontWeight.bold),),
              RaisedButton(
                child: Text('Add new inspection'),
                  onPressed: ()async {
                    Inspection i = await Navigator.push(context,
                        MaterialPageRoute(
                          builder: (BuildContext Context)=>NewInspection(inspectionList,projectID ) ,
                        ));
                    if (i ==null){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed"),
                          backgroundColor: Colors.grey,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    else{
                      inspectionList.add(i);
                     // Scaffold.of(context).showSnackBar(SnackBar(
                     //   content: Text('Saved'),
                     //   backgroundColor: Colors.green,
                     //   duration: Duration(seconds: 3),
                     // )
                     // );
                    }
                }
              )
          ]),
        )
            : ListView.builder(
          itemCount: inspectionList.length,
          itemBuilder:(context, i){
        return Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: InkWell(
                  onTap: (){
                 // var pic = base64.decode(inspectionList[i].ImageNearby);
                    Navigator.push(context, new MaterialPageRoute
                      (builder: (context) => InspectionDetail(inspectionList[i])));
                    },
                child:Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 350.0,
                          height: 50.0,
                          child: ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              child: Image.asset('assets/sadeem.png'),
                            ),
                            title: Text(inspectionList[i].name),
                            subtitle: Text(inspectionList[i].Sensor),
                            //subtitle: Text(country + " " + city),
                            onTap: () {
                            },
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                   IconButton( icon:
                                  Icon(Icons.edit, size: 25, color: Color.fromARGB(255, 56, 96,170),),
                                   onPressed: (){
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) =>
                                 UpdateInspectin(I_id:inspectionList[i].id, I_name:inspectionList[i].name,
                                     I_TunnelWidht: inspectionList[i].TunnelWidht, I_TunnelHeight: inspectionList[i].TunnelHeight,
                                     I_LampWidth: inspectionList[i].LampWidth, I_LampCircumference: inspectionList[i].LampCircumference,
                                    I_ImageNearby: inspectionList[i].ImageNearby, I_ImageOverall: inspectionList[i].ImageOverall,
                                     I_SunPath: inspectionList[i].SunPath, I_Latitude:inspectionList[i].Latitude, I_Longtitude: inspectionList[i].Longtitude,
                                     I_Status: inspectionList[i].Status , I_Sensor:inspectionList[i].Sensor,I_ProjectId: projectID, onUpdateInspectionList: _selfRefresh ) )
                                 );
                                 }),
                                    IconButton(
                                      icon: Icon(Icons.delete, size: 25, color: Color.fromARGB(255, 243, 146, 00),),
                                      onPressed: () {
                                        DeleteInspection(inspectionList,inspectionList[i].id );
                                        setState(() {
                                          inspectionList.removeAt(i);
                                        });
                                      }),
                                  ]
                              ),

                          ),
                        )
                      ],
                    )
                  ],
                ),              ),
              )
            );
          }),
      )
    );
  }
}

class AddInspection extends StatelessWidget {
  final List <Inspection> inspection;
  final int ProjectId ;
  AddInspection(this.inspection, this.ProjectId);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 40),
      icon: Icon(Icons.add, size: 40,color: Colors.white),
      onPressed: ()async {
        Inspection i = await Navigator.push(context,
            MaterialPageRoute(
              builder: (BuildContext Context)=>NewInspection(inspection,ProjectId ) ,
            ));
        if (i ==null){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed"),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 3),
            ),
          );
        }
        else{
          inspection.add(i);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Saved'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          )
          );
        }
      },

    );
  }
}
