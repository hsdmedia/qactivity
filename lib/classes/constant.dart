import 'package:flutter/material.dart';
import '../main.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);
const Color mainColor = Colors.white;
const Color blueColor = Color(0xFF1BCFFF);
const Color greyColor = Color(0xff465052);
const Color boxColor = Color(0xffFFCE82);
const Color trans = Colors.transparent;

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.black38,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
// void changeLanguage(String language, BuildContext context) async {
//   Locale _locale = await setLocale(language);
//   MyApp.setLocale(context, _locale);
// }

bool isUserVendor = false;

setUserVendor(bool value){
  isUserVendor = value;
}

bool getUserVendor(){
  return isUserVendor;
}

///////////////////////////////////////////////////////////////////////////////
class APIConstants {
  static const String OCTET_STREAM_ENCODING = "application/json";
  static const String API_BASE_URL_DEMO = "https://hsd-qatar.com/";
  static const String API_BASE_URL_DEV = "https://hsd-qatar.com/";
  //static const String API_BASE_URL_DEV =   "";
  // http://92.205.24.134/qactivity/register
  // http://92.205.24.134/qactivity/login
  // http://hsd-qatar.com/qactivity/newActivity
  // http://92.205.24.134/qactivity/getActivityById/629f267969d26cc5ea2182f0
  // https://hsd-qatar.com/qactivity/getAllActivities
}

///////////////////////////////////////////////////////////////////////////////
class APIOperations {
  static const String LOGIN = "qactivity/login";
  static const String REGISTER = "qactivity/register";
  static const String createNewActivity = "qactivity/newActivity";
  static const String getAllActivities = "qactivity/getAllActivities";
  // static const String HOME_PAGE = "departments";
  // static const String ListingDepartments = "listingDepartments";
  // static const String productsBydepartment = "productsByDepartment";
  // static const String ListingDepartmentsCategory = "listingCategories";
  // static const String VENDOR_LIST = "vendorList";
  // static const String packages = "packages";
  // static const String ADDTOCART = "addToCart";
  // static const String CHANGE_PASSWORD = "";
  // static const String SUCCESS = "success";
  // static const String FAILURE = "failure";
  // static const String AddList = "addNewList";
  // static const String listingbycategory = "listingByCategory";
  // static const String addAddress = "addAddress";
  // static const String deleteAddress = "deleteAddress";
  // static const String listAddress = "listAddress";
  // static const String newArrival = "newArrivalProducts";
}

class UIsizes {
  static const INPUT_BUTTON_BORDER_RADIUS = 30.0;
}

///////////////////////////////////////////////////////////////////////////////
class EventConstants {
  static const int NO_INTERNET_CONNECTION = 0;

///////////////////////////////////////////////////////////////////////////////
  static const int LOGIN_USER_SUCCESSFUL = 500;
  static const int LOGIN_USER_UN_SUCCESSFUL = 501;

///////////////////////////////////////////////////////////////////////////////
  static const int USER_REGISTRATION_SUCCESSFUL = 502;
  static const int USER_REGISTRATION_UN_SUCCESSFUL = 503;
  static const int USER_ALREADY_REGISTERED = 504;

///////////////////////////////////////////////////////////////////////////////
  static const int CHANGE_PASSWORD_SUCCESSFUL = 505;
  static const int CHANGE_PASSWORD_UN_SUCCESSFUL = 506;
  static const int INVALID_OLD_PASSWORD = 507;
///////////////////////////////////////////////////////////////////////////////
}

///////////////////////////////////////////////////////////////////////////////
class APIResponseCode {
  static const int SC_OK = 200;
}
///////////////////////////////////////////////////////////////////////////////

class SharedPreferenceKeys {
  static const String IS_USER_LOGGED_IN = "IS_USER_LOGGED_IN";
  static const String USER = "USER";
}

///////////////////////////////////////////////////////////////////////////////
class ProgressDialogTitles {
  static const String IN_PROGRESS = "In Progress...";
  static const String USER_LOG_IN = "Logging In...";
  static const String USER_CHANGE_PASSWORD = "Changing...";
  static const String USER_REGISTER = "Registering...";
}

///////////////////////////////////////////////////////////////////////////////
class SnackBarText {
  static const String NO_INTERNET_CONNECTION = "No Internet Conenction";
  static const String LOGIN_SUCCESSFUL = "Login Successful";
  static const String LOGIN_UN_SUCCESSFUL = "Login Un Successful";
  static const String CHANGE_PASSWORD_SUCCESSFUL = "Change Password Successful";
  static const String CHANGE_PASSWORD_UN_SUCCESSFUL =
      "Change Password Un Successful";
  static const String REGISTER_SUCCESSFUL = "Register Successful";
  static const String REGISTER_UN_SUCCESSFUL = "Register Un Successful";
  static const String USER_ALREADY_REGISTERED = "User Already Registered";
  static const String ENTER_PASS = "Please Enter your Password";
  static const String ENTER_NEW_PASS = "Please Enter your New Password";
  static const String ENTER_OLD_PASS = "Please Enter your Old Password";
  static const String ENTER_EMAIL = "Please Enter your Email Id";
  static const String ENTER_VALID_MAIL = "Please Enter Valid Email Id";
  static const String ENTER_NAME = "Please Enter your Name";
  static const String INVALID_OLD_PASSWORD = "Invalid Old Password";
}

///////////////////////////////////////////////////////////////////////////////
class Texts {
  static const String REGISTER_NOW = "Not Registered ? Register Now !";
  static const String LOGIN_NOW = "Already Registered ? Login Now !";
  static const String LOGIN = "LOGIN";
  static const String REGISTER = "REGISTER";
  static const String PASSWORD = "Password";
  static const String OLD_PASSWORD = "Old Password";
  static const String NEW_PASSWORD = "New Password";
  static const String CHANGE_PASSWORD = "CHANGE PASSWORD";
  static const String LOGOUT = "LOGOUT";
  static const String EMAIL = "Email";
  static const String NAME = "Name";
}
///////////////////////////////////////////////////////////////////////////////
