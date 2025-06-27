import 'package:buynow/routes/routes_name.dart';
import 'package:buynow/screen/add_product_screen.dart';
import 'package:buynow/screen/all_products.dart';
import 'package:buynow/screen/category_product_screen.dart';
import 'package:buynow/screen/details_screen.dart';
import 'package:buynow/screen/home_screen.dart';
import 'package:buynow/screen/login_screen.dart';
import 'package:buynow/screen/my_home_screen.dart';
import 'package:buynow/screen/sign_up_screen.dart';
import 'package:buynow/screen/splash_screen.dart';
import 'package:buynow/screen/user_acount_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: RoutesName.loginscreen, page: () => LoginScreen()),
    GetPage(name: RoutesName.homescreen, page: () => HomeScreen()),
    GetPage(name: RoutesName.myhomescreen, page: () => MyHomeScreen()),
    GetPage(name: RoutesName.signupscreen, page: () => SignUpScreen()),
    GetPage(name: RoutesName.allproducscreen, page: () => AllProducts()),
    GetPage(name: RoutesName.splashscreen, page: () => SplashScreen()),
    GetPage(name: RoutesName.useracount, page: () => UserAcountScreen()),
    GetPage(name: RoutesName.addproductscreen, page: () => AddProductScreen()),
    GetPage(name: RoutesName.detailsscreen, page: () => DetailsScreen()),
    GetPage(
        name: RoutesName.CategoryProductsScreen,
        page: () => CategoryProductsScreen()),
  ];
}
