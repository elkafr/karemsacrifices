import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/navigation_state.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/dialogs/log_out_dialog.dart';
import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/screens/account/about_app_screen.dart';
import 'package:karemsacrifices/screens/account/contact_with_us_screen.dart';
import 'package:karemsacrifices/screens/account/language_screen.dart';

import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double _height, _width;
  AppState _appState;
  NavigationState _navigationState;

  Widget _buildItem(
      {@required String imgPath,
      @required String title,
      @required Function onPressedItem}) {
    return GestureDetector(
      onTap: () => onPressedItem(),
      child: Container(
        height: 40,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                imgPath,
                color: cAccentColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  color: cBlack, fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        Image.asset(
          'assets/images/tobbg.png',
          fit: BoxFit.cover,
        ),
        Consumer<AppState>(builder: (context, appState, child) {
          return appState.currentUser != null
              ? Column(
                  children: <Widget>[
                    Container(
                    margin: EdgeInsets.only(
                        top: 10,
                       
                       ),  
                      child: _buildItem(
                          imgPath: 'assets/images/edit.png',
                          title: AppLocalizations.of(context).personalInfo,
                          onPressedItem: () {
                            Navigator.pushNamed(context, '/profile_screen' );
                          }),
                    ),
                    Divider(),
                  ],
                )
              : SizedBox(
                  height: 10,
                );
        }),
        _buildItem(
            imgPath: 'assets/images/opinion.png',
            title: AppLocalizations.of(context).customerOpinions,
            onPressedItem: () {
            Navigator.pushNamed(context,  '/customer_opinions_screen');
            }),
        Divider(),
        _buildItem(
            imgPath: 'assets/images/bank.png',
            title: AppLocalizations.of(context).bankAccounts,
            onPressedItem: () {
            Navigator.pushNamed(context, '/bank_accounts_screen');
            }),
        Divider(),
        _buildItem(
            imgPath: 'assets/images/lang.png',
            title: AppLocalizations.of(context).language,
            onPressedItem: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LanguageScreen()));
            }),
        Divider(),
        _buildItem(
            imgPath: 'assets/images/contact.png',
            title: AppLocalizations.of(context).contactUs,
            onPressedItem: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactWithUsScreen()));
            }),
        Divider(),
        _buildItem(
            imgPath: 'assets/images/about.png',
            title: AppLocalizations.of(context).about,
            onPressedItem: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutAppScreen()));
            }),
        Divider(),
        Consumer<AppState>(builder: (context, appState, child) {
          return appState.currentUser != null
              ? _buildItem(
                  imgPath: 'assets/images/logout.png',
                  title: AppLocalizations.of(context).logOut,
                  onPressedItem: () {
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (_) {
                          return LogoutDialog(
                            alertMessage:
                                AppLocalizations.of(context).wantToLogout,
                            onPressedConfirm: () {
                              Navigator.pop(context);
                              SharedPreferencesHelper.remove("user");
                              _appState.setCurrentUser(null);
                              _navigationState.upadateNavigationIndex(0);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/navigation',
                                  (Route<dynamic> route) => false);
                            },
                          );
                        });
                  })
              : _buildItem(
                  imgPath: 'assets/images/login.png',
                  title: AppLocalizations.of(context).login,
                  onPressedItem: () {
                    Navigator.pushNamed(context, '/login_screen');
                  });
        })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _appState = Provider.of<AppState>(context);
    _navigationState = Provider.of<NavigationState>(context);

    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
        backgroundColor: cWhite,
        body: _buildBodyItem(),
      ),
    ));
  }
}
