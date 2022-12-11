import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/progress_indicator_state.dart';
import 'package:karemsacrifices/components/buttons/custom_button.dart';
import 'package:karemsacrifices/components/connectivity/network_indicator.dart';
import 'package:karemsacrifices/components/custom_text_form_field/custom_text_form_field.dart';
import 'package:karemsacrifices/components/horizontal_divider/horizontal_divider.dart';
import 'package:karemsacrifices/components/progress_indicator_component/progress_indicator_component.dart';
import 'package:karemsacrifices/components/response_handling/response_handling.dart';
import 'package:karemsacrifices/components/safe_area/page_container.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/services/access_api.dart';
import 'package:karemsacrifices/utils/app_colors.dart';
import 'package:karemsacrifices/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

class ContactWithUsScreen extends StatefulWidget {
  ContactWithUsScreen({Key key}) : super(key: key);

  @override
  _ContactWithUsScreenState createState() => _ContactWithUsScreenState();
}

class _ContactWithUsScreenState extends State<ContactWithUsScreen> {
  double _height;
  double _width;
  String _userEmail = '' ,_messageTitle = '', _userName ='', _messageContent = '';
  Services _services = Services();
  AppState _appState;
  ProgressIndicatorState _progressIndicatorState;
  // String _facebookUrl = '',
  //     _instragramUrl = '',
  //     _linkedinUrl = '',
  //     _twitterUrl = '';


  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // Future<Null> _getSocialContact() async {
  //   var results = await _services.get(Utils.BASE_URL + 'social');

  //   if (results['response'] == '1') {
  //     _facebookUrl = results['setting_facebook'];
  //     _twitterUrl = results['setting_twitter'];
  //     _linkedinUrl = results['setting_linkedin'];
  //     _instragramUrl = results['setting_instigram'];
  //   } else {
  //     print('error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //_getSocialContact();
  }

  
   bool _checkValidation(BuildContext context, {String name, String email,
   String messageTitle,String messageContent}) {
    if (name.trim().length == 0) {
      showToast(AppLocalizations.of(context).nameValidation, context,
          color: cRed);
      return false;
    } 
    else if (!isEmail(email)) {
      showToast(AppLocalizations.of(context).emailValidation, context,
          color: cRed);
      return false;
    }
    else if (messageTitle.trim().length == 0) {
      showToast(AppLocalizations.of(context).textValidation, context,
          color: cRed);
      return false;
    } 
    else if (messageContent.trim().length == 0) {
      showToast(AppLocalizations.of(context).textValidation, context,
          color: cRed);
      return false;
    } 
    return true;
  }



  Widget _buildBodyItem() {
    return  
        ListView(
          children: <Widget>[
               SizedBox(
              height: 15,
            ),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Divider(),
             Container(
                      margin: EdgeInsets.only(top: 10),
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
                      margin: EdgeInsets.only(top: 10),
                      child: CustomTextFormField(
                       
                        prefixIconIsImage: true,
                        prefixIconImagePath: 'assets/images/edit.png',
                        hintTxt: AppLocalizations.of(context).messageTitle,
                        onChangedFunc: (String text) {
                         _messageTitle = text;
                        },
                        inputData: TextInputType.text,
                      )),
                      Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
         
          ),
          height: 100,
          child: CustomTextFormField(   
            maxLines: 5,
            onChangedFunc: (String text) {
              _messageContent = text;
            },
            hintTxt: AppLocalizations.of(context).messageDescription,
          )),
           CustomButton(
                    btnLbl: AppLocalizations.of(context).send,
                    onPressedFunction: () async {
                    if(  _checkValidation(context,name: _userName,email: _userEmail,
                      messageTitle: _messageTitle,messageContent: _messageContent)){
        _progressIndicatorState.setIsLoading(true);

                    var results = await _services.get(
                      '${Utils.BASE_URL}contact?msg_name=$_userName&msg_email=$_userEmail&msg_title=$_messageTitle&msg_content=$_messageContent&lang=${_appState.currentLang}',
                    );
                    _progressIndicatorState.setIsLoading(false);
                    if (results['response'] == '1') {
                      showToast(results['message'], context);
                      Navigator.pop(context);
                    } else {
                      showErrorDialog(results['message'], context);
                    }
                      }
                        
                    })
       
           ,
            Container(
              margin: EdgeInsets.only(
                top: _height * 0.02,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                        right: _width * 0.07, left: _width * 0.02),
                    child: Divider(
                      color: Colors.grey[400],
                      height: 2,
                      thickness: 1,
                    ),
                  )),
                  Center(
                    child: Text(
                    AppLocalizations.of(context).or,
                      style: TextStyle(
                          color: cBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                        left: _width * 0.07, right: _width * 0.02),
                    child: Divider(
                      color: Colors.grey[400],
                      height: 2,
                      thickness: 1,
                    ),
                  ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: _width * 0.1, vertical: _height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        // _launchURL(_twitterUrl);
                      },
                      child: Image.asset(
                        'assets/images/twitter.png',
                        height: 40,
                        width: 40,
                      )),
                  GestureDetector(
                      onTap: () {
                        // _launchURL(_linkedinUrl);
                      },
                      child: Image.asset(
                        'assets/images/linkedin.png',
                        height: 40,
                        width: 40,
                      )),
                  GestureDetector(
                      onTap: () {
                        // _launchURL(_instragramUrl);
                      },
                      child: Image.asset(
                        'assets/images/instagram.png',
                        height: 40,
                        width: 40,
                      )),
                  GestureDetector(
                      onTap: () {
                        // _launchURL(_facebookUrl);
                      },
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 40,
                        width: 40,
                      )),
                ],
              ),
            ),
      GestureDetector(
          onTap: (){
            launch("tel://9666666666");
          },
          child: Container(
           margin: EdgeInsets.only(bottom: 10),
           alignment: Alignment.center,
           child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: cBlack,
                          fontSize: 16,
                          fontFamily: 'HelveticaNeueW23forSKY'),
                      children: <TextSpan>[
                        TextSpan(text: AppLocalizations.of(context).youCanConnectWithUS ),
                        TextSpan(text: '  '),
                        TextSpan(
                          text: '9666666666',
                          style: TextStyle(
                              color: cBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: 'HelveticaNeueW23forSKY'),
                        ),
                      ],
                    ),
                  ),
         ))
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      title: Text(AppLocalizations.of(context).contactUs, style: Theme.of(context).textTheme.display1),
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
    _progressIndicatorState = Provider.of<ProgressIndicatorState>(context);
    _appState = Provider.of<AppState>(context);
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
                ))));
  }
}
