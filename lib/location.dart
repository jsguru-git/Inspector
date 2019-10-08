import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
class Getlocation extends StatefulWidget {
  @override
  _GetlocationState createState() => _GetlocationState();
}

class _GetlocationState extends State<Getlocation> {
  GoogleMapController mycontroller;
  String searchadress;
  double Latitude;
  double Longtitude;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: onMapCreated ,
                initialCameraPosition: CameraPosition(
                  target: LatLng(21.4858, 39.1925),
                  zoom: 10.0,
                ),
              ),
              Positioned(
                top: 30.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                    height: 50.0,
                    width: double.infinity,
                    child:  IconButton(
                        icon: Icon(Icons.location_on),
                        onPressed: searchNav,

                        iconSize: 50.0)
                ),
              ),
              Row(
                children: <Widget>[
                 RaisedButton(
                   child: Text("Add location"),
                     onPressed: (){
                     print(Longtitude);
                     Navigator.pop(context, Longtitude);
                     })
                ],
              )
            ]
        )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checker();
  }

  void checker() async {
    final GeolocationStatus result = await Geolocator()
        .checkGeolocationPermissionStatus();
    if (result == GeolocationStatus.disabled) {
      print("faild");
    }
    else {
      print("success");
    }
  }

  void searchNav() async{
    Position position =await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      mycontroller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(position.latitude, position.longitude),
              zoom: 16.0)
      ));
     Latitude = position.latitude;
     Longtitude = position.longitude;
     print("$Latitude \n $Longtitude");
    });
  }

  void onMapCreated (GoogleMapController controller){
    setState(() {
      mycontroller = controller;
    });
  }
}

