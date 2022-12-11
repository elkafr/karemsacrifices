import 'package:flutter/material.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/auth_state.dart';
import 'package:karemsacrifices/app_repo/progress_indicator_state.dart';
import 'package:karemsacrifices/components/buttons/custom_button.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:karemsacrifices/components/drop_down_list_selector/default_shape_drop_down.dart';
import 'package:karemsacrifices/components/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:karemsacrifices/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:karemsacrifices/components/response_handling/response_handling.dart';
import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/models/city.dart';
import 'package:karemsacrifices/models/user.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  double _height = 0, _width = 0;

  String _userName = '', _userEmail = '', _userPhone = '', _userPassword = '' ,_userPasswordVerify = '';
  Services _services = Services();
  ProgressIndicatorState _progressIndicatorState;
  AppState _appState;
    Future<List<City>> _cityList;
  City _selectedCity;
    bool _initialRun = true;
    AuthState _authState;


  Future<List<City>> _getCityList() async {
    Map<String, dynamic> results =
        await _services.get(Utils.CITIES_URL, header: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': _appState.currentLang
    });
    List<City> cityList = List<City>();
    if (results['response'] == '1') {
      Iterable iterable = results['city'];
      cityList = iterable.map((model) => City.fromJson(model)).toList();
    } else {
      showErrorDialog(results['msg'], context);
    }
    return cityList;
  }

    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _appState = Provider.of<AppState>(context);
       _cityList = _getCityList();
      _initialRun = false;
    }
  }

  bool _checkValidation(BuildContext context,{String  userName ,
   String userEmail , String userPhone , String userPassword ,
  String userPasswordVerify ,City  selectedCity}) {
    if (userName.trim().length == 0) {
      showToast(
        AppLocalizations.of(context).nameValidation,
        context,
        color: cRed
      );
      return false;
    } else if (!isEmail(userEmail)) {
      showToast(
        AppLocalizations.of(context).emailValidation,
        context,
           color: cRed
      );
      return false;
    } else if (!isNumeric(userPhone)) {
      showToast(
        AppLocalizations.of(context).phonoNoValidation,
        context,
           color: cRed
      );
      return false;
    } else if (selectedCity == null) {
      showToast(
        AppLocalizations.of(context).cityValidation,
        context,
           color: cRed
      );
      return false;
    } else if (_userPassword.trim().length == 0) {
      showToast(AppLocalizations.of(context).passwordValidation, context,   color: cRed);
      return false;
    } else if (userPasswordVerify != _userPassword) {
      showToast(AppLocalizations.of(context).passwordNotIdentical, context,   color: cRed);
      return false;
    } else {
      return true;
    }
  }

  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: _width,
        ),
       Container(
                      margin: EdgeInsets.only(top: 20),
                      child: CustomTextFormField(
                   
                    prefixIconIsImage: true,
                    prefixIconImagePath: 'assets/images/profile.png',
                    hintTxt: AppLocalizations.of(context).name,
                    onChangedFunc: (String text) {
                      _userName = text;
                    },
                    inputData: TextInputType.text,
                  )),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: CustomTextFormField(
                       
                        prefixIconIsImage: true,
                        prefixIconImagePath: 'assets/images/phone.png',
                        hintTxt: AppLocalizations.of(context).phoneNo,
                        onChangedFunc: (String text) {
                          _userPhone = text;
                        },
                        inputData: TextInputType.number,
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: CustomTextFormField(
                         prefixIconIsImage: true,
                        prefixIconImagePath: 'assets/images/email.png',
                        hintTxt: AppLocalizations.of(context).email,
                       
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                          _userEmail = text;
                        },
                      )),
                        Container(
                      margin: EdgeInsets.only(top: 10 ),
                      child: FutureBuilder<List<City>>(
                        future: _cityList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var cityList = snapshot.data.map((item) {
                              return new DropdownMenuItem<City>(
                                child: new Text(item.cityName),
                                value: item,
                              );
                            }).toList();
                            return DropDownListSelector(
                              dropDownList: cityList,
                              hint: AppLocalizations.of(context).city,
                              onChangeFunc: (newValue) {
                                setState(() {
                                  _selectedCity = newValue;
                                });
                              },
                              value: _selectedCity,
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                        return DefaultShapeOfDropDown(
              hint: AppLocalizations.of(context).city,
            );
                        },
                      )),
        Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: CustomTextFormField(
                        prefixIconIsImage: true,
                        prefixIconImagePath:  'assets/images/key.png',
                        isPassword: true,
                        hintTxt: AppLocalizations.of(context).password,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                          _userPassword = text.toString();
                        },
                      )),
                  Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      child: CustomTextFormField(
                        prefixIconIsImage: true,
                        prefixIconImagePath:  'assets/images/key.png',
                        isPassword: true,
                        hintTxt:
                            AppLocalizations.of(context).passwordVerify,
                        inputData: TextInputType.text,
                        onChangedFunc: (String text) {
                          _userPasswordVerify = text.toString();
                        },
                      )),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: CustomButton(
            btnLbl: AppLocalizations.of(context).createAccount,
            onPressedFunction: () async {
             if (_checkValidation(context,userName: _userName,userEmail: _userEmail,
              userPhone: _userPhone,selectedCity: _selectedCity,userPassword: _userPassword,
              userPasswordVerify: _userPasswordVerify
              )){
                
                _progressIndicatorState.setIsLoading(true);
                  
                      var results = await _services.get(
                          '${Utils.REGISTER_URL}user_name=$_userName&user_phone=$_userPhone&user_email=$_userEmail&user_pass=$_userPassword&lang=${_appState.currentLang}&user_city=${_selectedCity.cityId}');
                      _progressIndicatorState.setIsLoading(false);
                      if (results['response'] == '1') {
                        showToast(results['message'], context);
                        _authState.setUserId(results['user_id'].toString());
                        _authState.setUserPhone(_userPhone);
                        Navigator.pushNamed(context,  '/account_activation_screen');
                      } else {
                        showErrorDialog(results['message'], context);
                      }
           
              }
              
     
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 10
          ),
          child: CustomButton(
              borderColor: cAccentColor,
              btnStyle: TextStyle(
                  fontFamily: 'HelveticaNeueW23forSKY',
                  color: cAccentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
              btnColor: cWhite,
              btnLbl: AppLocalizations.of(context).hasAccount,
              onPressedFunction: () async {
                  Navigator.pushNamed(context, '/login_screen');
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        backgroundColor: cPrimaryColor,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).createAccount,
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
