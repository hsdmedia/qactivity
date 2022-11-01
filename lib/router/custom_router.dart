import 'package:flutter/material.dart';
import 'package:flutter_localization_master/pages/about_page.dart';
import 'package:flutter_localization_master/pages/activity_list_screen.dart';
import 'package:flutter_localization_master/pages/explore_screen.dart';
import 'package:flutter_localization_master/pages/login_screen.dart';
import 'package:flutter_localization_master/pages/main_screen.dart';
import 'package:flutter_localization_master/pages/not_found_page.dart';
import 'package:flutter_localization_master/pages/settings_page.dart';
import 'package:flutter_localization_master/pages/signup_screen.dart';
import 'package:flutter_localization_master/pages/splash_screen.dart';
import 'package:flutter_localization_master/router/route_constants.dart';

import '../pages/select_user_type.dart';
import '../pages/user_type_screen.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => MainScreen(selectedPage: 0,));
      case aboutRoute:
        return MaterialPageRoute(builder: (_) => AboutPage());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case exploreRoute:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case categoryRoute:
        return MaterialPageRoute(builder: (_) => ExploreScreen());
      case activityListRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case detailRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case activityListRoute:
        return MaterialPageRoute(builder: (_) => ActivityList());
      case detailRoute:
        return MaterialPageRoute(builder: (_) => ActivityList());
      case chooseUserRoute:
        return MaterialPageRoute(builder: (_) => ChooseUserType());
      case userTypesScreen:
        return MaterialPageRoute(builder: (_) => UserTypesScreen());
      default:
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}
