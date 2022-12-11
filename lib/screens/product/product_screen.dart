import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/product_state.dart';
import 'package:karemsacrifices/app_repo/progress_indicator_state.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/dialogs/crop_dialog.dart';
import 'package:karemsacrifices/components/dialogs/encupsulation_dialog.dart';
import 'package:karemsacrifices/components/dialogs/head_and_seat_dialog.dart';
import 'package:karemsacrifices/components/dialogs/rumen_and_insistence_dialog.dart';
import 'package:karemsacrifices/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:karemsacrifices/components/response_handling/response_handling.dart';

import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/components/title_item/title_item.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/product_details.dart';
import 'package:karemsacrifices/screens/product/components/another_option.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:karemsacrifices/models/option.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  double _height = 0, _width = 0;
  Services _services = Services();
  AppState _appState;
  bool _initialRun = true;
  ProductState _productState;
  Future<ProductDetails> _productDetails;
    ProgressIndicatorState _progressIndicatorState;

  Future<ProductDetails> _getProductDetails() async {
    Map<String, dynamic> results = await _services.get(
        Utils.SHOW_PRODUCT_DETAILS_URL +
            _appState.currentLang +
            '&id=${_productState.productId}');
    ProductDetails productDetails = ProductDetails();
    List<Option> sizeList = List<Option>();
    List<Option> choppingList = List<Option>();
    List<Option> encapsulationList = List<Option>();
    List<Option> headAndSeatList = List<Option>();
    List<Option> rumenAndInsistenceList = List<Option>();

    if (results['response'] == '1') {
      productDetails = ProductDetails.fromJson(results['details']);

      Iterable iterable = results['options1'];
      sizeList = iterable.map((model) => Option.fromJson(model)).toList();
      // if(sizeList.length  == 0){
      //  Option option =  Option(
      //    optionsPrice: 0,optionsName: AppLocalizations.of(context).notFound
      //  );
      //  sizeList.add(option);
      // }
      sizeList[0].isSelected = true;
      _productState.setLastSelectedSize(sizeList[0]);
      _productState.setSizeList(sizeList);

      iterable = results['options2'];
      choppingList = iterable.map((model) => Option.fromJson(model)).toList();
      //  if(choppingList.length  == 0){
      //  Option option =  Option(
      //    optionsPrice: 0,optionsName: AppLocalizations.of(context).notFound
      //  );
      //  choppingList.add(option);
      // }
      choppingList[0].isSelected = true;
      _productState.setLastSelectedChopping(choppingList[0]);
      _productState.setChoppingList(choppingList);

      iterable = results['options3'];
      encapsulationList =
          iterable.map((model) => Option.fromJson(model)).toList();
      //       if(encapsulationList.length  == 0){
      //  Option option =  Option(
      //    optionsPrice: 0,optionsName: AppLocalizations.of(context).notFound
      //  );
      //  encapsulationList.add(option);
      // }
      encapsulationList[0].isSelected = true;
      _productState.setLastSelectedEncapsulation(encapsulationList[0]);
      _productState.setEncapsulationList(encapsulationList);

      iterable = results['options4'];
      headAndSeatList =
          iterable.map((model) => Option.fromJson(model)).toList();
      //             if(headAndSeatList.length  == 0){
      //  Option option =  Option(
      //    optionsPrice: 0,optionsName: AppLocalizations.of(context).notFound
      //  );
      //  headAndSeatList.add(option);
      // }
      headAndSeatList[0].isSelected = true;
      _productState.setLastSelectedHeadAndSeat(headAndSeatList[0]);
      _productState.setHeadAndSeatList(headAndSeatList);

      iterable = results['options5'];
      rumenAndInsistenceList =
          iterable.map((model) => Option.fromJson(model)).toList();
      //             if(rumenAndInsistenceList.length  == 0){
      //  Option option =  Option(
      //    optionsPrice: 0,optionsName: AppLocalizations.of(context).notFound
      //  );
      //  rumenAndInsistenceList.add(option);
      // }
      rumenAndInsistenceList[0].isSelected = true;
      _productState
          .setLastSelectedRumenAndInsistence(rumenAndInsistenceList[0]);
      _productState.setRumenAndInsistenceList(rumenAndInsistenceList);

      print(_productState.lastSelectedChopping.optionsPrice +
          _productState.lastSelectedEncapsulation.optionsPrice +
          _productState.lastSelectedHeadAndSeat.optionsPrice +
          _productState.lastSelectedRumenAndInsistence.optionsPrice);

      _productState.setTotalCost(_productState.lastSelectedSize.optionsPrice +
          _productState.lastSelectedChopping.optionsPrice +
          _productState.lastSelectedEncapsulation.optionsPrice +
          _productState.lastSelectedHeadAndSeat.optionsPrice +
          _productState.lastSelectedRumenAndInsistence.optionsPrice);
    } else {
      print('error');
    }
    return productDetails;
  }

  @override
  void didChangeDependencies() {
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _productState = Provider.of<ProductState>(context);
      _productDetails = _getProductDetails();
      _initialRun = false;
    }
    super.didChangeDependencies();
  }

  Widget _buildBodyItem() {
    return Consumer<ProductState>(builder: (context, homeState, child) {
      return FutureBuilder<ProductDetails>(
          future: _productDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: <Widget>[
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(
                        left: _width * 0.04, right: _width * 0.04, top: 20),
                
                    child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  child:  Image.network(
                        
                        snapshot.data.adsMtgerPhoto,
                        fit: BoxFit.cover,
                     
                      
                      ),
                    
                  )),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data.adsMtgerName,
                      style: TextStyle(
                          color: cBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                      height: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 5, left: _width * 0.3, right: _width * 0.3),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.00),
                          ),
                          color: cAccentColor),
                      child: Consumer<ProductState>(
                          builder: (context, productState, child) {
                        return RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: cBlack,
                                fontSize: 16,
                                fontFamily: 'HelveticaNeueW23forSKY'),
                            children: <TextSpan>[
                              TextSpan(text: productState.totalCost.toString()),
                              TextSpan(text: '  '),
                              TextSpan(
                                text: AppLocalizations.of(context).sr,
                                style: TextStyle(
                                    color: cBlack,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    fontFamily: 'HelveticaNeueW23forSKY'),
                              ),
                            ],
                          ),
                        );
                      })),
                  TitleItem(
                    title: AppLocalizations.of(context).sacrificeDescription,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04, vertical: 5),
                      child: Text(
                        snapshot.data.adsMtgerContent,
                        style: TextStyle(
                            color: cBlack,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            height: 1.5),
                      )),
                  TitleItem(
                    title: AppLocalizations.of(context).size,
                  ),
                  Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Consumer<ProductState>(
                        builder: (context, productState, child) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productState.sizeList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: _width * 0.3,
                               padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    const Radius.circular(10.00),
                                  ),
                                  border: Border.all(color: cHintColor)),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                       productState
                                        .updateChangesOnSizeList(index);
                                        productState.updateTotalCost();
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      margin: EdgeInsets.only(
                                          
                                          right: 5),
                                      child: productState
                                              .sizeList[index].isSelected
                                          ? Icon(
                                              Icons.check,
                                              color: cAccentColor,
                                              size: 17,
                                            )
                                          : Container(),
                                      decoration: BoxDecoration(
                                      
                                        border: Border.all(
                                          color: cHintColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        productState
                                            .sizeList[index].optionsName,
                                        style: TextStyle(
                                            color: cBlack,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '${productState.sizeList[index].optionsPrice} ${AppLocalizations.of(context).sr}',
                                        style: TextStyle(
                                            color: cPrimaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    }),
                  ),
                  TitleItem(
                    title: AppLocalizations.of(context).amount,
                  ),
                  Consumer<ProductState>(
                      builder: (context, productState, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            productState.increaseTotalNumber();
                            productState.updateTotalCost();
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 5),
                            child: Image.asset('assets/images/plus.png')),
                        ),
                        Container(
                            height: 32,
                            width: _width * 0.2,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.00),
                                ),
                                border: Border.all(color: cHintColor)),
                            child: Text(productState.totalNumber.toString(),
                            style: TextStyle(
                              color: cPrimaryColor,fontSize: 16,
                              fontWeight: FontWeight.w700
                            ),)),
                        GestureDetector(
                          onTap: () {
                            productState.decreaseTotalNumber();
                            productState.updateTotalCost();
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 5),
                            child:  Image.asset('assets/images/minus.png'),)
                        ),
                      ],
                    );
                  })
              ,
                 TitleItem(
                    title: AppLocalizations.of(context).anotherOptions,
                  ),
                  GestureDetector(
                    onTap: (){
                         showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return CropDialog();
                        });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10
                      ),
                      child: Consumer<ProductState>(
                       builder: (context,productState,child){
                         return AnotherOption(
                        imgPath: 'assets/images/crop.png',
                        title: AppLocalizations.of(context).croping,
                        value:  productState.lastSelectedChopping.optionsName,
                      );
                       }
                      )),
                  ),
                   GestureDetector(
                    onTap: (){
                         showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return EncupsulationDialog();
                        });
                    },
                    child:  Container(
                      child: Consumer<ProductState>(
                       builder: (context,productState,child){
                         return AnotherOption(
                        imgPath: 'assets/images/box.png',
                        title: AppLocalizations.of(context).encupsulation,
                        value:  productState.lastSelectedEncapsulation.optionsName,
                      );
                       }
                      ),
                    ),),


                     GestureDetector(
                    onTap: (){
                         showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return HeadAndSeatDialog();
                        });
                    },
                    child:   Container(
                      child: Consumer<ProductState>(
                       builder: (context,productState,child){
                         return AnotherOption(
                        imgPath: 'assets/images/sheep.png',
                        title: AppLocalizations.of(context).headAndSeat,
                        value:  productState.lastSelectedHeadAndSeat.optionsName,
                      );
                       }
                      ),
                    )),
                         GestureDetector(
                    onTap: (){
                         showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return RumenAndInsistenceDialog();
                        });
                    },
                    child:  Container(
                      child: Consumer<ProductState>(
                       builder: (context,productState,child){
                         return AnotherOption(
                        imgPath: 'assets/images/stomach.png',
                        title: AppLocalizations.of(context).rumenAndInsistence,
                        value:  productState.lastSelectedRumenAndInsistence.optionsName,
                      );
                       }
                      ),
                    ),),

                    Divider(),
                    Container(
                     margin: EdgeInsets.only(
                       bottom: 10
                     ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                           Container(
                        height: 40,
                        width: 60,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            top: 5, left: 10,right:10),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.00),
                            ),
                            color: cAccentColor),
                        child: Text(AppLocalizations.of(context).total,
                        style: TextStyle(
                          color: cBlack,fontSize: 14,fontWeight:
                           FontWeight.w400
                        ),)),
                      Consumer<ProductState>(
                           builder: (context,productState,child){
                             return  RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: cBlack,
                                  fontSize: 16,
                                  fontFamily: 'HelveticaNeueW23forSKY'),
                              children: <TextSpan>[
                                TextSpan(text: productState.totalCost.toString()),
                                TextSpan(text: '  '),
                                TextSpan(
                                  text: AppLocalizations.of(context).sr,
                                  style: TextStyle(
                                      color: cBlack,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'HelveticaNeueW23forSKY'),
                                ),
                              ],
                            ),
                          );
                           }
                         ),
                       
                        ],
                      ),
                    )

                ,
              GestureDetector(
                onTap: () async {
                    if(_appState.currentUser != null){
                       _progressIndicatorState.setIsLoading(true);
                          var results = await _services.get( 
                             '${Utils.ADD_TO_CART_URL}${_appState.currentLang}&user_id=${_appState.currentUser.userId}&ads_id=${_productState.productId}&amountt=${_productState.totalNumber}&options1=${_productState.lastSelectedSize.optionsId}&options2=${_productState.lastSelectedChopping.optionsId}&options3=${_productState.lastSelectedEncapsulation.optionsId}&options4=${_productState.lastSelectedHeadAndSeat.optionsId}&options5=${_productState.lastSelectedRumenAndInsistence.optionsId}}',
                          );
                          _progressIndicatorState.setIsLoading(false);
                          if (results['response'] == '1') {
                           
                            showToast(results['message'], context);
                       
                          } else {
                            showErrorDialog(results['message'], context);
                          }
                    }
                    else{
                      Navigator.pushNamed(context,  '/login_screen');
                    }
                },
                child:   Container(
                  height: 45,
                  color: cPrimaryColor,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Image.asset('assets/images/cart.png',color:cWhite ,),
                     Container(
                       margin: EdgeInsets.symmetric(horizontal: 10),
                       child: Text(AppLocalizations.of(context).addToCart,
                       style: TextStyle(
                       fontSize: 15,
                       fontWeight: FontWeight.w700,color: cWhite
                       
                     ),),
                     )
                   ],
                 )
                ))   
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
                child: SpinKitSquareCircle(color: cPrimaryColor, size: 25));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text(_productState.productTitle,
            style: Theme.of(context).textTheme.display1),
        leading: GestureDetector(
          child: Consumer<AppState>(
            builder: (context,appState,child){
              return appState.currentLang == 'ar' ? Image.asset('assets/images/back_ar.png'):
              Image.asset('assets/images/back_en.png');

            }
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ));
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
  
    return NetworkIndicator(child: PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            _buildBodyItem(),
              Center(
            child: ProgressIndicatorComponent(),
          )
          ],
        ),
      ),
    ));
  }
}
