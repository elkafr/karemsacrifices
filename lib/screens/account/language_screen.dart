import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/locale/Locale_helper.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:provider/provider.dart';



class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  double _height, _width;
  AppState _appState;

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
      
            SharedPreferencesHelper.setUserLang('ar');
            helper.onLocaleChanged(new Locale('ar'));
            _appState.setCurrentLanguage('ar');
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: Image.asset('assets/images/arabic.png'),
              ),
              Text(
                AppLocalizations.of(context).arabic,
                style: TextStyle(color: cBlack, fontSize: 15),
              )
            ],
          ),
        ),
        Divider(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
           
            SharedPreferencesHelper.setUserLang('en');
            helper.onLocaleChanged(new Locale('en'));
            _appState.setCurrentLanguage('en');
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                child: Image.asset('assets/images/english.png'),
              ),
              Text(
               AppLocalizations.of(context).english,
                style: TextStyle(color: cBlack, fontSize: 15),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
        _appState = Provider.of<AppState>(context);
    final appBar = AppBar(
      centerTitle: true,
      title: Text(AppLocalizations.of(context).language, style: Theme.of(context).textTheme.display1),
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
    );

    _height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    return NetworkIndicator(child: PageContainer(
      child: Scaffold(
        appBar: appBar,
        body: _buildBodyItem(),
      ),
    ));
  }
}
