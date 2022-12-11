import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/home_state.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/no_data/no_data.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/category.dart';
import 'package:karemsacrifices/models/sacrifice.dart';
import 'package:karemsacrifices/screens/home/components/sacrifice_item.dart';
import 'package:karemsacrifices/screens/home/components/slider_images.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState _appState;
  HomeState _homeState;
  bool _initialRun = true;
  Future<List<Category>> _categoriesList;
  Future<List<Sacrifice>> _sacrificesList;
  

  Future<List<Category>> _getCategories() async {
    Map<String, dynamic> results =
        await _services.get(Utils.CATEGORIES_URL + _appState.currentLang);
    List<Category> categoryList = List<Category>();
    if (results['response'] == '1') {
      Iterable iterable = results['city'];
      categoryList = iterable.map((model) => Category.fromJson(model)).toList();
      if(categoryList.length >0){
      _homeState.setCategoriesList(categoryList);
      }
       _sacrificesList = _getSacrificesOFCategory('0');   
    } else {
      print('error');
    }
    return categoryList;
  }
     
  Future<List<Sacrifice>> _getSacrificesOFCategory(String categoryId) async {
    Map<String, dynamic> results =
        await _services.get(Utils.SHOW_CATEGORY_URL +'lang=${_appState.currentLang}&page=1&cat_id=${categoryId.toString()}');
    List<Sacrifice> sacrificeList = List<Sacrifice>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      sacrificeList = iterable.map((model) => Sacrifice.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sacrificeList;
  }

    Future<List<Sacrifice>> _getSearchResults(String categoryId ,String title) async {
    Map<String, dynamic> results =
        await _services.get(Utils.SHOW_SEARCH_RESULT_URL +'lang=${_appState.currentLang}&title=$title&cat_id=${categoryId.toString()}');
    List<Sacrifice> sacrificeList = List<Sacrifice>();
    if (results['response'] == '1') {
      Iterable iterable = results['results'];
      sacrificeList = iterable.map((model) => Sacrifice.fromJson(model)).toList();
    } else {
      print('error');
    }
    return sacrificeList;
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _homeState = Provider.of<HomeState>(context);
      _categoriesList = _getCategories();
   
      _initialRun = false;
    }
    super.didChangeDependencies();
  }


  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 90,
            child: Consumer<HomeState>(builder: (context, homeState, child) {
              return FutureBuilder<List<Category>>(
                future: _categoriesList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                     if (snapshot.data.length > 0) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                homeState.updateChangesOnCategoriesList(index);
                                 _sacrificesList = _getSacrificesOFCategory(snapshot.data[index].mtgerCatId);
                                 setState(() {
                                   
                                 });
                              },
                              child: Container(
                                width: _width * 0.22,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: <Widget>[
                                          Image.network(homeState
                                              .categoriesList[index]
                                              .mtgerCatPhoto),
                                          Text(
                                            homeState.categoriesList[index]
                                                .mtgerCatName,
                                            style: TextStyle(
                                                color: cBlack, fontSize: 13),
                                          ),
                                         homeState.categoriesList[index]
                                                .isSelected ?  Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 2,
                                            width: _width * 0.13,
                                            color: cAccentColor,
                                          ) : Container()
                                        ],
                                      ),
                                    ),
                                    index != homeState.categoriesList.length - 1
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 25, horizontal: 5),
                                            child: VerticalDivider(
                                              color: cHintColor,
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ));
                        });
               }
              else {
                        return NoData(
                          message: AppLocalizations.of(context).noResults
                        );
                      }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(
                      child:
                          SpinKitSquareCircle(color: cPrimaryColor, size: 25));
                },
              );
            })),
        SliderImages(),

        Container(
              margin: EdgeInsets.symmetric( horizontal: 5),
              height: _height - 330,
              child:  FutureBuilder<List<Sacrifice>>(
                  future: _sacrificesList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return GridView.builder(
                            physics:  ClampingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.97,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return SacrificesItem(
                              sacrifice: snapshot.data[index],
                              );
                            });
                      } else {
                        return NoData(
                          message: AppLocalizations.of(context).noResults
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                        child: SpinKitThreeBounce(
                      color: cPrimaryColor,
                      size: 40,
                    ));
                  })
               ),

      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      backgroundColor: cPrimaryColor,
      centerTitle: true,
      title: Container(
          height: 45,
          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              color: cWhite, borderRadius: BorderRadius.circular(10.0)),
          child: TextFormField(
              cursorColor: cHintColor,
              maxLines: 1,
              onChanged: (text) {
                 _sacrificesList =   _getSearchResults(_homeState.lastSelectedCategory.toString(),text);
            setState(() {
             
            });
              },
              style: TextStyle(
                  color: cBlack, fontSize: 15, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: cPrimaryColor),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                prefixIcon: Image.asset(
                  'assets/images/search.png',
                  color: cHintColor,
                ),
                hintText: AppLocalizations.of(context).search,
                errorStyle: TextStyle(fontSize: 12.0),
                hintStyle: TextStyle(
                    color: cHintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ))),
      leading: Image.asset('assets/images/toplogo.png'),
    );

    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return  NetworkIndicator(
        child: Scaffold(
      appBar: appBar,
      body: _buildBodyItem(),
    ));
  }
}
