import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/navigation_state.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/user.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:provider/provider.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool _initialRun = true;
  AppState _appState;
  NavigationState _navigationState;


  Future<Null> _checkIsLogin() async {
    var userData = await SharedPreferencesHelper.read("user");
    if (userData != null) {
      _appState.setCurrentUser(User.fromJson(userData));
    }
  }


 

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) { 
      _appState = Provider.of<AppState>(context);
      _checkIsLogin();
        _initialRun = false;
      
    }
  }

  @override
  Widget build(BuildContext context) {
    _navigationState = Provider.of<NavigationState>(context);
    return NetworkIndicator(
        child: Scaffold(
      body: _navigationState.selectedContent,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
               color: Color(0xFFC7C7C7),
            ),
            activeIcon: Image.asset(
              'assets/images/home.png',
              color: cPrimaryColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
               AppLocalizations.of(context).home,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),
           BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/cart.png',
              color: Color(0xFFC7C7C7),
            ),
            activeIcon: Image.asset(
              'assets/images/cart.png',
              color: cPrimaryColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                AppLocalizations.of(context).cart,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/requests.png',
               color: Color(0xFFC7C7C7),
            ),
             activeIcon: Image.asset(
              'assets/images/requests.png',
              color: cPrimaryColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).orders,
                  style: TextStyle(fontSize: 14.0),
                )),
          ),
            BottomNavigationBarItem(
           icon: Image.asset(
              'assets/images/profile.png',
               color: Color(0xFFC7C7C7),
            ),
            activeIcon: Image.asset(
              'assets/images/profile.png',
              color: cPrimaryColor,
            ),
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                 AppLocalizations.of(context).account,
                  style: TextStyle(fontSize: 14.0),
                )),
          )
        ],
        currentIndex: _navigationState.navigationIndex,
        selectedItemColor: cPrimaryColor,
        unselectedItemColor: Color(0xFFC4C4C4),
        onTap: (int index) {
          _navigationState.upadateNavigationIndex(index);
        },
        elevation: 5,
        backgroundColor: cWhite,
        type: BottomNavigationBarType.fixed,
      ),
    ));
  }
}
