import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _height, _width;
  AppState _appState;
  
    Future initData() async {
    await Future.delayed(Duration(seconds: 2));
  }


  
  Future<void> _getLanguage() async {
    String currentLang = await SharedPreferencesHelper.getUserLang();
    _appState.setCurrentLanguage(currentLang);
  }


  @override
  void initState() {
    super.initState();
       _getLanguage();
    initData().then((value) {
     Navigator.pushReplacementNamed(context,  '/navigation');
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
     _appState = Provider.of<AppState>(context);
   
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        fit: BoxFit.fill,
        height: _height,
        width: _width,
      ),
    );
  }
}
