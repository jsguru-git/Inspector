import 'dart:convert';
import 'package:api_app/InspectionListView.dart';
import 'package:api_app/Models.dart';
import 'package:api_app/NewPorject.dart';
import 'package:api_app/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_app/UpdateProject.dart';

class ProjectListView extends StatefulWidget {

 final int countryID;
 final String countryName;
 ProjectListView({this.countryID, this.countryName}):super();

  @override
  _ProjectListState createState()=> _ProjectListState(countryID, countryName);
}

class _ProjectListState extends State<ProjectListView> {

  final int countryID;
  final String countryName;
  List<Project> projectList = new List<Project>();

  _ProjectListState(this.countryID, this.countryName);
  Map<String, String> headers = {"Content-type": "application/json"};
  void initState() {
    super.initState();
    getProjectList(this.countryID);
  }

  void getProjectList(int c_id) {
    http.get(URL.URL_PROJECT + c_id.toString()).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        projectList = list.map((model) => Project.fromJson(model)).toList();
        print(response.request);
      });
    });
  }
  void DeleteProject ( List <Project> item, int p_id){
    http.delete(URL.URL_PROJECT+ p_id.toString(), headers: headers).then((http.Response response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 160.0,
            floating: false,
            pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('assets/HD.jpg',fit: BoxFit.cover,),
                title: Text(countryName, style: TextStyle(fontSize: 20.0,height:5.0,)),
              ),
            actions: <Widget>[
              IconButton(
                icon: AddProject(projectList, countryID),
              )
            ],
          ),
          SliverFillRemaining(
            child: projectList.length ==0 ?
            Center(child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 200),),
                Text("No Projects " , style: TextStyle(fontWeight: FontWeight.bold),),
                RaisedButton(
                  child: Text('Add new project'),
                  onPressed: ()async {
                    Project p = await Navigator.push(context,
                        MaterialPageRoute(
                          builder: (BuildContext Context)=> NewProject(projectList,countryID),
                        ));
                    if (p==null){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed"),
                          backgroundColor: Colors.grey,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                    else{
                      projectList.add(p);
                     // Scaffold.of(context).showSnackBar(SnackBar(
                      //  content: Text('Saved'),
                      //  backgroundColor: Colors.green,
                     //   duration: Duration(seconds: 3),
                     // )
                     // );
                    }
                  },
                )
              ],
            ),)
            :ListView.builder(
              itemCount: this.projectList.length,
              itemBuilder: (context, i){
                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: InkWell (
                    onTap: (){
                      Navigator.push(context, new MaterialPageRoute <Map> (
                        builder: (context) => InspectionListView(projectID: projectList[i].id, country: countryName, city: projectList[i].city)),
                      );
                     // print(projectList[i].CountryId);
                    },
                    child: Container(
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
                                    child: Image.asset('assets/sadeem.png'),),
                                  title: Text(projectList[i].name),
                                  subtitle: Text(projectList[i].city),
                                  trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton( icon:
                                    Icon(Icons.edit, size: 25, color: Color.fromARGB(255, 56, 96,170),),
                                        onPressed: (){
                                          Navigator.push(context,
                                          MaterialPageRoute(builder: (BuildContext context) =>UpdateProject(P_id:projectList[i].id, p_name: projectList[i].name,
                                              p_city: projectList[i].city, p_orgnazation: projectList[i].orgnazation,
                                              p_latitude: projectList[i].latitude, p_longtitude: projectList[i].longtitude,Countryid: countryID ) )
                                          );
                                        }),
                                    IconButton(icon:
                                    Icon(Icons.delete, size: 25, color: Color.fromARGB(255, 243, 146, 00),),
                                          onPressed: () {
                                      return showDialog<Confirmation>(
                                        context: context,
                                          barrierDismissible: false,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Text("Delete?"),
                                            content: Text("Are you sure you want to delete "+projectList[i].name),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: const Text("CANCEL"),
                                                onPressed: (){
                                                  Navigator.of(context).pop(Confirmation.CANCEL);
                                                },
                                              ),
                                              FlatButton(
                                                child: const Text("YES"),
                                                onPressed: (){
                                                  Navigator.of(context).pop(Confirmation.ACCEPT);
                                                  DeleteProject(projectList, projectList[i].id);
                                                  setState(() {
                                                    projectList;
                                                  });
                                              }
                                              )
                                            ],
                                          );
                                        });// DeleteProject(projectList,projectList[i].id );
                                        }),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ]
                      )
                    )
                  )
                );
              },
            )
          )
        ],
      ),
    );
  }
}

class AddProject extends StatelessWidget {
  final List<Project> project;
  final int CountryId;
  AddProject (this.project, this.CountryId);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 40),
      icon: Icon(Icons.add, size: 40,color: Colors.white),
      onPressed: ()async {
        print(CountryId);
        Project p = await Navigator.push(context,
            MaterialPageRoute(
              builder: (BuildContext Context)=> NewProject(project,CountryId),
            ));
        if (p==null){
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed"),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 3),
            ),
          );
        }
        else{
          project.add(p);
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
enum Confirmation {CANCEL, ACCEPT }