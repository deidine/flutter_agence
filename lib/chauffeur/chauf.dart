import 'package:deidine/chauffeur/add.dart';
import 'package:deidine/widgets/drawer.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import '../const/const.dart';
import '../data/data.dart';

class Data_Chauf extends StatefulWidget {
  @override
  _Data_ChaufState createState() => _Data_ChaufState();
}

class _Data_ChaufState extends State<Data_Chauf> {

  final PageController _pageController = PageController(initialPage: 0);

  List<Data> datas = getDataList();
  List<Filter> filters = getFilterList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: Icon(
            Icons.menu,
            size: 32,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 24),
            child: Icon(
              Feather.shopping_bag,
              size: 32,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(left: 24, top: 16, bottom: 16,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

          const    Text(
                "Les Chauffeurs",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 32,
              ),

              Container(
                height: 60,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildFilters(),
                ),
              ),

              SizedBox(
                height: 32,
              ),

              Container(
                height: 350,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildItems(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildFilters(){
    List<Widget> list = [];
    list.add(buildFilterIcon());
    for (var filter in filters) {
      list.add(buildFilterOption(filter));
    }
    return list;
  }

  Widget buildFilterIcon(){
    return Container(
      width: 60,
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Icon(
          Octicons.settings,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  Widget buildFilterOption(Filter filter){
    return GestureDetector(
      onTap: () {
        setState(() {
          filter.selected = !filter.selected;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: filter.selected ? kGreen : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(
            width: 1,
            color: filter.selected ? kGreen : Colors.grey,
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: 32,),
        margin: EdgeInsets.only(right: 12),
        child: Center(
          child: Text(
            filter.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: filter.selected ? Colors.white : kGreen,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildItems(){
    List<Widget> list = [];
    for (var data in datas) {
      list.add(buildItem(data));
    }
    return list;
  }

  Widget buildItem(Data data){

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => add()),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Container(
            width: 200,
            height: 270,
            decoration: BoxDecoration(
              gradient: kGradient,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            margin: EdgeInsets.only(right: 24),
            child: Stack(
              children: <Widget>[

                GestureDetector(
                  onTap: () {
                    setState(() {
                      data.favorite = !data.favorite;
                        String  url=data.path;
  debugPrint (url);
                    });
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(
                          data.favorite ? Icons.favorite : Icons.favorite_border,
                          size: 32,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16,),
                  child: Center(
                    child: Hero(
                      tag: data.name,
                      child: Image.asset(
                        data.images[0],
                        fit: BoxFit.fitHeight,
                        height: 160,
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            data.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

 
}