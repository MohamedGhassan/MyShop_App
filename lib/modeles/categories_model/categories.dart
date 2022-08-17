class CategoryModel {
  bool ? status;

  DataModel ?categoryData;

  CategoryModel.fromJson (Map <String, dynamic>json){
    status = json['status '];
    categoryData = DataModel.fromJson(json['data'] )   ;
  }
}
class DataModel{
  int ?currentPage;
   List <DataInfo>  dataInfo=[] ;
  DataModel.fromJson ( Map <String, dynamic >json  ){

    currentPage =json['current_page '];
    json['data'].forEach((element) {
      dataInfo.add(DataInfo.fromJson(element));
    });

      }

}
class DataInfo {
int ? id ;
String ? name;
String ? image ;

DataInfo.fromJson ( Map <String, dynamic >json  ){

  id =json['id '];
  name=json['name']
  ;
  image=json['image'];
}
}