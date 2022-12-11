import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/order_state.dart';
import 'package:karemsacrifices/app_repo/progress_indicator_state.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/option_title/option_title.dart';
import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/order.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _initialRun = true;
  OrderState _orderState;
  double _height, _width;
  Services _services = Services();
  AppState _appState;
  Future<Order> _orderDetails;

  Future<Order> _getOrderDetails() async {
    Map<String, dynamic> results = await _services.get(
        '${Utils.SHOW_ORDER_DETAILS_URL}lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}&cartt_fatora=${_orderState.carttFatora}');
    Order orderDetails = Order();
    if (results['response'] == '1') {
      orderDetails = Order.fromJson(results['result']);
    } else {
      print('error');
    }
    return orderDetails;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _initialRun = false;
      _appState = Provider.of<AppState>(context);
      _orderState = Provider.of<OrderState>(context);
      _orderDetails = _getOrderDetails();
    }
  }

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
       
        children: <Widget>[
          Text(
            '$title  :  ',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: cBlack),
          ),
            Text(value,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: cBlack))
        ],
      ),
    );
  }

  Widget _buildCartItem(CarttDetail carttDetail , bool enableDivider) {
    return Container(
      height: 190,
        margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         Container(
           margin: EdgeInsets.only(
            top: 15,bottom: 5
           ),
           child:  Text(
            carttDetail.carttName,
            style: TextStyle(
                color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
          ),
         ),
           OptionTitle( title:
                    AppLocalizations.of(context).croping,value: carttDetail.options2Name),
              
              OptionTitle( title:AppLocalizations.of(context).encupsulation,
                value:  carttDetail.options3Name),
              OptionTitle(
                 title: AppLocalizations.of(context).headAndSeat,value: carttDetail.options4Name),
              OptionTitle( title:AppLocalizations.of(context).rumenAndInsistence,
              value:    carttDetail.options5Name),
              Container(
                   margin: EdgeInsets.only(
                          top: 10),
                child: Row(
                  children: <Widget>[
                      Container(
                        height: 30,
                        width: _width *0.25,
                        alignment: Alignment.center,
                     
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6.00),
                            ),
                            color: cAccentColor),
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: cBlack,
                                    fontSize: 14,
                                    fontFamily: 'HelveticaNeueW23forSKY'),
                                children: <TextSpan>[
                                  TextSpan(text: carttDetail.carttPrice.toString()),
                                  TextSpan(text: '  '),
                                  TextSpan(
                                    text: AppLocalizations.of(context).sr,
                                    style: TextStyle(
                                        color: cBlack,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'HelveticaNeueW23forSKY'),
                                  ),
                                ],
                              ),
                            ),
                        )),
                        Container(
                              height: 30,
                              width: _width * 0.15,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6.00),
                                  ),
                                  border: Border.all(color: cHintColor)),
                              child: Text(carttDetail.carttAmount.toString(),
                              style: TextStyle(
                                color: cPrimaryColor,fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),)),
                              Divider() 
                  

                  ],
                ),
              ),
             enableDivider ?   Container(
                height: 1,
                margin: EdgeInsets.symmetric(vertical: 15),
                width: _width ,
                color: Colors.grey[300],
              ) : Container(),
             
              
                      
        ],
      ),
    );
  }

  Widget _buildBodyItem() {
    return FutureBuilder<Order>(
        future: _orderDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  Container(
                width: _width,
                height: _height,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: _height * 0.6,
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                          itemCount: snapshot.data.carttDetails.length,
                          itemBuilder: (context, index) {
                            return _buildCartItem(
                                snapshot.data.carttDetails[index] , index != snapshot.data.carttDetails.length - 1 ? true : false);
                          }),
                    ),
                     Container(
                height: 70 ,
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                 decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            const Radius.circular(15.00),
          ),
          border: Border.all(color: cHintColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildRow( AppLocalizations.of(context).orderDate,
               snapshot.data.carttDate),
                _buildRow( AppLocalizations.of(context).orderPrice, '${snapshot.data.carttTotlal.toString()} ${AppLocalizations.of(context).sr}')
            ],
          ),
              )
                  ],
                ),
              
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(
              child: SpinKitThreeBounce(
            color: cPrimaryColor,
            size: 40,
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;

    final appBar = AppBar(
        backgroundColor: cPrimaryColor,
        centerTitle: true,
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
        ),
        title: Consumer<OrderState>(builder: (context, orderState, child) {
          return Text(orderState.carttFatora,
              style: Theme.of(context).textTheme.display1);
        }));

    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(appBar: appBar, body: _buildBodyItem())));
  }
}
