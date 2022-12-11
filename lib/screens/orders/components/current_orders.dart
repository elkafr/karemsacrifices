import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/components/no_data/no_data.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/order.dart';
import 'package:karemsacrifices/screens/orders/components/order_item.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';

class CurrentOrders extends StatefulWidget {
  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
   bool _initialRun = true;
  AppState _appState;
  Services _services = Services();
  Future<List<Order>> _orderList;

    Future<List<Order>> _getOrderList() async {
    Map<String, dynamic> results = await _services.get(
        '${Utils.ORDERS_URL}lang=${_appState.currentLang}&user_id=${_appState.currentUser.userId}&page=1&done=0');
    List orderList = List<Order>();
    if (results['response'] == '1') {
      Iterable iterable = results['result'];
      orderList = iterable.map((model) => Order.fromJson(model)).toList();
    } else {
      print('error');
    }
    return orderList;
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
      _orderList = _getOrderList();
      _initialRun = false;
    }
  }

   @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Order>>(
      future: _orderList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
                  return
                   
                       ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OrderItem(
                                order: snapshot.data[index],
                              );
                            })
                      ;
                  
               
          } else {
            return NoData(
              message: AppLocalizations.of(context).noResults,
            );
          }
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }

        return Center(
            child: SpinKitThreeBounce(
          color: cPrimaryColor,
          size: 40,
        ));
      },
    );
  }
  }
