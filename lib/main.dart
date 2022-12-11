import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:karemsacrifices/app_data/shared_preferences_helper.dart';
import 'package:karemsacrifices/app_repo/app_state.dart';
import 'package:karemsacrifices/app_repo/auth_state.dart';
import 'package:karemsacrifices/app_repo/home_state.dart';
import 'package:karemsacrifices/app_repo/navigation_state.dart';
import 'package:karemsacrifices/app_repo/order_state.dart';
import 'package:karemsacrifices/app_repo/product_state.dart';
import 'package:karemsacrifices/app_repo/progress_indicator_state.dart';
import 'package:karemsacrifices/app_repo/tab_state.dart';
import 'package:karemsacrifices/locale/Locale_helper.dart';
import 'package:karemsacrifices/locale/localization.dart';
import 'package:karemsacrifices/theme/style.dart';
import 'package:karemsacrifices/utils/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   SpecificLocalizationDelegate _specificLocalizationDelegate;

  onLocaleChange(Locale locale) {
    setState(() {
      _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  Future<void> _getLanguage() async {
    String language = await SharedPreferencesHelper.getUserLang();
    onLocaleChange(Locale(language));
  }

  @override
  void initState() {
    super.initState();

    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(new Locale('ar'));
   _getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return
        // add multiprovider
        MultiProvider(
            providers: [
          ChangeNotifierProvider(create: (_) => ProgressIndicatorState()),
          ChangeNotifierProvider(
            create: (_) => AppState(),
          ),
          ChangeNotifierProvider(create: (_) => NavigationState()),
          ChangeNotifierProvider(create: (_) => HomeState()),
          ChangeNotifierProvider(create: (_) => ProductState()),
            ChangeNotifierProvider(create: (_) => OrderState()),
                ChangeNotifierProvider(create: (_)=> TabState()),
                  ChangeNotifierProvider(create: (_)=> AuthState()),
          
        ],
            child: MaterialApp(
                //   builder: DevicePreview.appBuilder,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  _specificLocalizationDelegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en'),
                  Locale('ar')
                ],
                locale: _specificLocalizationDelegate.overriddenLocale,
                debugShowCheckedModeBanner: false,
                title: 'ذبائح رواق',
                theme: themeData(),
               routes: routes
                ));
  }
}
