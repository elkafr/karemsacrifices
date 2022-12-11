import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/auth_state.dart';
import 'package:karemsacrifices/app_repo/progress_indicator_state.dart';
import 'package:karemsacrifices/components/buttons/custom_button.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:karemsacrifices/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:karemsacrifices/components/response_handling/response_handling.dart';
import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  @override
  _PasswordRecoveryScreenState createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  double _height = 0, _width = 0;

  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
  AuthState _authState;
  String _userNewPassword = '', _confirmNewPassword = '';

  bool _checkValidation(BuildContext context,
      {String newPassword, String confirmNewPassword}) {
    if (newPassword.trim().length == 0) {
      showToast(AppLocalizations.of(context).passwordValidation, context,
          color: cRed);
      return false;
    } else if (confirmNewPassword.trim().length == 0) {
      showToast(AppLocalizations.of(context).passwordValidation, context,
          color: cRed);
      return false;
    } else if (confirmNewPassword != newPassword) {
      showToast(AppLocalizations.of(context).passwordNotIdentical, context,
          color: cRed);
      return false;
    }
    return true;
  }

  Widget _buildBodyItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Image.asset(
          'assets/images/full_edit.png',
          height: 70,
          width: _width,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context).restorePassword,
            style: TextStyle(
                color: cBlack, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 10),
          child: Text(
            AppLocalizations.of(context).changePasswordToRestoreItNow,
            style: TextStyle(
                color: cHintColor, fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: CustomTextFormField(
              prefixIconIsImage: true,
              prefixIconImagePath: 'assets/images/key.png',
              isPassword: true,
              hintTxt: AppLocalizations.of(context).newPassword,
              inputData: TextInputType.text,
              onChangedFunc: (String text) {
                _userNewPassword = text.toString();
              },
            )),
        Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: CustomTextFormField(
              prefixIconIsImage: true,
              prefixIconImagePath: 'assets/images/key.png',
              isPassword: true,
              hintTxt: AppLocalizations.of(context).confirmNewPassword,
              inputData: TextInputType.text,
              onChangedFunc: (String text) {
                _confirmNewPassword = text.toString();
              },
            )),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: CustomButton(
              btnLbl: AppLocalizations.of(context).restorePassword,
              onPressedFunction: () async {
                if (_checkValidation(context,
                    newPassword: _userNewPassword,
                    confirmNewPassword: _confirmNewPassword)) {
                  {
                    _progressIndicatorState.setIsLoading(true);

                    var results = await _services.get(
                        'https://works.rawa8.com/apps/karem/api/pass_recover/?user_id=${_authState.userId}&user_pass=$_userNewPassword&user_pass_repeat=$_confirmNewPassword&lang=${_appState.currentLang}');
                    _progressIndicatorState.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(results['message'], context);
                      Navigator.pushNamed(context, '/login_screen');
                    } else {
                      showErrorDialog(results['message'], context);
                    }
                  }
                }
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).restorePassword,
            style: Theme.of(context).textTheme.display1),
        leading: IconButton(
          icon: Consumer<AppState>(
            builder: (context,appState,child){
              return appState.currentLang == 'ar' ? Image.asset('assets/images/back_ar.png'):
              Image.asset('assets/images/back_en.png');

            }
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
    _authState = Provider.of<AuthState>(context);

    return NetworkIndicator(
        child: PageContainer(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
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
