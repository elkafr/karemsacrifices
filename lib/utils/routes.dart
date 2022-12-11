import 'package:karemsacrifices/screens/account/bank_accounts_screen.dart';
import 'package:karemsacrifices/screens/account/customer_opinions_screen.dart';
import 'package:karemsacrifices/screens/account/modify_password_screen.dart';
import 'package:karemsacrifices/screens/account/modify_personal_info_screen.dart';
import 'package:karemsacrifices/screens/account/profile_screen.dart';
import 'package:karemsacrifices/screens/auth/account_activation_screen.dart';
import 'package:karemsacrifices/screens/auth/login_screen.dart';
import 'package:karemsacrifices/screens/auth/password_activation_code_screen.dart';
import 'package:karemsacrifices/screens/auth/password_recovery_screen.dart';
import 'package:karemsacrifices/screens/auth/register_screen.dart';
import 'package:karemsacrifices/screens/bottom_navigation.dart/bottom_navigation_bar.dart';
import 'package:karemsacrifices/screens/orders/order_details_screen.dart';
import 'package:karemsacrifices/screens/product/product_screen.dart';
import 'package:karemsacrifices/screens/splash/splash_screen.dart';

final routes = {
  '/': (context) => SplashScreen(),
  '/login_screen': (context) => LoginScreen(),
  // '/forget_password_screen': (context) => ForgetPasswordScreen(),
   '/password_recovery_screen': (context) => PasswordRecoveryScreen(),
  '/navigation': (context) => BottomNavigation(),
  '/product_screen':(context) => ProductScreen(),
  '/order_details_screen':(context) =>  OrderDetailsScreen(),
  '/bank_accounts_screen':(context) => BankAccountScreen(),
  '/customer_opinions_screen' :(context) => CustomerOpinionsScreen(),
  '/profile_screen' :(context) => ProfileScreen(),
  '/modify_password_screen' :(context) => ModifyPasswordScreen(),
  '/modify_personal_info_screen':(context) => ModifyPersonalInfoScreen(),
  '/register_screen' : (context) => RegisterScreen() ,
  '/account_activation_screen' :(context) => AccountActivationScreen(),
  '/password_activation_code_screen':(context) =>  PasswordActivationCodeScreen()

  
 
};
