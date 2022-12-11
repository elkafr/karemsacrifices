
import 'package:flutter/material.dart';
import 'package:karemsacrifices/screens/account/account_screen.dart';
import 'package:karemsacrifices/screens/cart/cart_screen.dart';
import 'package:karemsacrifices/screens/home/home_screen.dart';
import 'package:karemsacrifices/screens/orders/orders_screen.dart';



class NavigationState extends ChangeNotifier {

    int _navigationIndex = 0 ;


  void upadateNavigationIndex(int value ){
    _navigationIndex = value;
    notifyListeners();
  }

  int get navigationIndex => _navigationIndex;


    List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
    OrdersScreen(),
    AccountScreen()
  
  ];
  
  Widget get  selectedContent => _screens[_navigationIndex];

}