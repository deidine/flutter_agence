class Data {

  String path;
  String name;
  String description;
  List<String> images;
  bool favorite;

  Data(this.path,this.name,this.favorite, this.description,this.images);

}

List<Data> getDataList(){
  return <Data>
  [

Data("add","ENREGISTRER UN CLIENT",false,"Lancome",["assets/images/la_vie_est_belle_0.png",],),
Data("chauffeur_list","AFFICHER TOUTE LES CHAUFFEUR",false,"Lancome", ["assets/images/la_vie_est_belle_0.png",],),

  ];
}

class Filter {
  String name;
  bool selected;

  Filter(this.name, this.selected);

}

List<Filter> getFilterList(){
  return <Filter>
                 [

Filter("les chauffeur",false,),Filter("les clients",false,)
                 
                 ];
}