import 'dart:async';
import 'dart:convert';
import 'package:api_app/ProjectListView.dart';
import 'package:api_app/Models.dart';
import 'package:flutter/material.dart';
import 'package:api_app/global.dart';
import 'package:http/http.dart' as http;
import 'package:api_app/NewCountry.dart';
import 'package:api_app/UpdateCountry.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {

  List<Country> countryList = new  List<Country>();
  final GlobalKey <ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Map<String, String> headers = {"Content-type": "application/json"};
  TextEditingController controller = new TextEditingController();
  List <Country> _search =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryList();
  }

   void getCountryList() {
    http.get(URL.URL_COUNTRY).then((response) {
      setState(() {
        Iterable list = json.decode(response.body); //Iterable a collection of values, or "elements", that can be accessed sequentially.
        countryList = list.map((model) => Country.fromJson(model)).toList();
      });
    });
  }
  void DeleteCountry ( List <Country> item, int c_id){
    http.delete(URL.URL_COUNTRY+ c_id.toString(), headers: headers).then((http.Response response){
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.reasonPhrase);
      print(response.request);

    });
  }
  Future<Country> _refresh() {
     getCountryList();
    setState(() {
      countryList;
    });
  }
  Future<Null> _Refresh() {
    print('refreshed');
    Completer<Null> completer = new Completer<Null>();
  }

  OnSearch(String text) async{
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return countryList;
    }
    countryList.forEach((s){
      if (s.name.contains(text) || s.name.contains(text))_search.add(s);
    });
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 10.0,
        title: new Padding(padding: EdgeInsets.only(left: 10.0),
          child: Text('Countries'),
        ),
       // actions: <Widget>[
       //   IconButton(
       //     icon: AddCountry(countryList),
       //   )
       // ],
      ),

      body:Container(

        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              TextField(
                controller: controller,
                onChanged: OnSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: InputBorder.none,
                  icon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: (){
                        controller.clear();
                        OnSearch('');
                      })
                ),
              ),
        Expanded(
          child: _search !=0 || controller.text.isNotEmpty ?
        ListView.builder(
          itemCount: _search.length,
          itemBuilder:(context, i){
            return Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: InkWell (
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
                              leading: CircleAvatar(child: Image.asset('assets/sadeem.png'),
                              ),
                              title: Text(_search[i].name),
                              subtitle: Text("test"),
                              onTap: (){
                                Navigator.push(context, new MaterialPageRoute <Map> (
                                    builder: (context) => ProjectListView(countryID: _search[i].id, countryName: _search[i].name))
                                );
                              },
                          trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                           children: <Widget>[
                           IconButton( icon:
                           Icon(Icons.edit, size: 25, color: Color.fromARGB(255, 56, 96,170),),
                           onPressed: (){
                             _refresh();
                           Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) =>UpdateCountry(countryID: _search[i].id, countryName: _search[i].name)));

                              }),
                           //  IconButton(icon:
                           //  Icon(Icons.delete, size: 25, color: Color.fromARGB(255, 243, 146, 00),),
                           //    onPressed: () {
                           //      DeleteCountry(_search,_search[i].id );
                           //      _refresh();
                           //    }
                           //  ),
                           IconButton(
                               icon: const Icon(Icons.refresh),
                               tooltip: 'Refresh',
                               onPressed: () {
                               _refresh();
                                 //_refreshIndicatorKey.currentState.dispose();
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
          }
        )
        :
          ListView.builder(
            itemCount: countryList.length,
            itemBuilder: (context,i){
              return Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(3.0),
                  ),
                child: InkWell(
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
                              width: 350,
                                height: 50,
                              child: ListTile(
                                  isThreeLine: true,
                                  leading: CircleAvatar(child: Image.asset('assets/sadeem.png'),
                                  ),
                                title: Text(countryList[i].name),
                                subtitle: Text("test"),
                                onTap: (){
                                  Navigator.push(context, new MaterialPageRoute <Map> (
                                   builder: (context) => ProjectListView(countryID: countryList[i].id, countryName: countryList[i].name))
                                  );
                                 // Row()
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        )
            ]
        )
      ),
    );
  }

}

class AddCountry extends StatelessWidget {
  final List <Country> country;
  //final int countryID;
  AddCountry(this.country);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 40),
        icon: Icon(Icons.add, size: 40, color: Colors.white,),
        onPressed: () async {
          Country c = await Navigator.push(context,
              MaterialPageRoute(
                  builder: (BuildContext Context) => NewCountry(country ),
              )
          );
          if (c==null){
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed"),
                backgroundColor: Colors.grey,
                duration: Duration(seconds: 3),
              ),
            );
          }
          else{
            country.add(c);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Saved'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            )
            );
          }
        }
    );
  }
}
