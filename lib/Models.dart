
class Country {
  int id;
  String name;

  Country( {this.id, this.name});

int get Id => id;
String get Name=> name;
  factory Country.fromJson(Map<String, dynamic> json){
    return Country(
        id: json["id"],
        name: json["name"],
    );
  }
 Map<String, dynamic> toMap(int c_id){
   final Map<String, dynamic> item = <String, dynamic>{
     "name": name,
   };
   if ( c_id != null)
     item["id"]= id;
   return item;
 // var map = Map<String, dynamic>();
 // map["name"]= name;
 // if (id != null){
 // map["id"]= id;
 // }
 // return map;
  }
  Map<String, dynamic> toMapEdit(int c_id) {
    return {
    "id" : id,
    "name": name

  };
  }
}

class Project {

  int id;
  String name;
  String city;
  String orgnazation;
  double latitude;
  double longtitude;
  int CountryId;

  Project ({this.id,this.name, this.city, this.orgnazation, this.latitude, this.longtitude, this.CountryId,});

 int get ID =>id;
 String get Name => name;
 String get City=> city;
 String get Orgnazation => orgnazation;
 double get Latitude => latitude;
 double get Longtitude=> longtitude;
 int get countryid => CountryId;

 factory Project.fromJson(Map<String, dynamic> json){
   return Project(
       id: json["id"],
       name: json["name"],
       city: json["city"],
       orgnazation: json["orgnazation"],
       latitude: json["latitude"],
       longtitude: json["longtitude"],
       CountryId: json["CountryId"]
   );
 }
  Map<String, dynamic> toMap(int p_id){
    final map = Map<String, dynamic>();
    //final Map<String, dynamic> item =  <String, dynamic>
     if (p_id != null)
       map ["id"] =id;
      map ["name"]= name;
      map["city"]= city;
      map["orgnazation"]=orgnazation;
      map["latitude"]= latitude;
      map["longtitude"]=longtitude;
      map["countryId"]=CountryId;

   // if (p_id != null)
   //   item ["id"] =id;
    return map;
  }
  Map<String, dynamic> toMapEdit(int p_id){
    final map = Map<String, dynamic>();
    //final Map<String, dynamic> item =  <String, dynamic>
    map ["id"] =id;
    map ["name"]= name;
    map["city"]= city;
    map["orgnazation"]=orgnazation;
    map["latitude"]= latitude;
    map["longtitude"]=longtitude;
    map["countryId"]=CountryId;

    // if (p_id != null)
    //   item ["id"] =id;
    return map;
  }
}


class Inspection {

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


  Inspection({this.id, this.name, this.TunnelWidht, this.TunnelHeight, this.LampWidth,
    this.LampCircumference, this.ImageNearby, this.ImageOverall, this.SunPath, this.Latitude,
      this.Longtitude, this.Status, this.Sensor, this.ProjectId});

 factory Inspection.fromJson(Map<String, dynamic > json){
    return Inspection(
     id : json["id"],
     name :json["name"],
     TunnelWidht : json["tunnelWidth"],
     TunnelHeight :json["tunnelHeight"],
     LampWidth : json ["lampWidth"],
     LampCircumference : json["lampCircumference"],
     ImageNearby :json["imageNearby"],
     ImageOverall: json["imageOverall"],
     SunPath : json["sunPath"],
     Sensor : json["sensor"],
     Latitude : json["latitude"],
     Longtitude :json["longtitude"],
     Status :json["status"],
     ProjectId:json["projectId"]
   );
 }
  Map <String , dynamic> toMap(int i_id){
    final item= Map<String, dynamic>() ;
    if (i_id != null)
      item ["id"]= id;
      item["name"]= name;
      item["tunnelWidth"]= TunnelWidht;
     item["tunnelHeight"]= TunnelHeight;
     item["lampWidth"]= LampWidth;
     item["lampCircumference"]= LampCircumference;
     item["imageNearby"]= ImageNearby;
     item["imageOverall"]= ImageOverall;
     item["sunPath"] = SunPath;
     item["latitude"]=Latitude;
     item["longtitude"] = Longtitude;
     item["status"]= Status;
     item["sensor"]= Sensor;
     item["projectId"]= ProjectId;
return item;
  }
 Map <String , dynamic> toMapEdit(){
   return {
     "id": id,
     "name": name,
     "tunnelWidth": TunnelWidht,
     "tunnelHeight": TunnelHeight,
     "lampWidth": LampWidth,
     "lampCircumference": LampCircumference,
     "imageNearby": ImageNearby,
     "imageOverall": ImageOverall,
     "sunPath" : SunPath,
     "latitude": Latitude,
     "longtitude" : Longtitude,
     "status": Status,
     "sensor": Sensor,
     "projectId": ProjectId
   };
 }
}