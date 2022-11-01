import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/router/route_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //StreamSubscription _connectionChangeStream;
  bool _isLoggedIn = false;

  bool isOffline = false;

  //SharedPreferences sharedPreferences; ///Uncomment it

  get subscription => null;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, _checkIfLoggedIn);

    ///_checkIfLoggedIn
  }

  @override
  void initState() {
    networkChecked();
    //_checkIfLoggedIn();
    super.initState();
    startTime();
    //checkLoginStatus();
    // FirebaseNotifications().setUpFirebase();   ///Uncomment it
  }

  // dispose() {
  //   subscription.cancel();
  // }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    //var branchID = localStorage.getString('branchId');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
        print("User Is Logged In");
        Navigator.pushNamed(context, homeRoute);
        //_gotoMainpage();
      });
    } else {
      print("User Is Not Logged In");
      Navigator.pushNamed(context, exploreRoute);
      ///Navigator.pushNamed(context, chooseUserRoute);///used this when choose the user
      // Navigator.pushReplacement(
      //   context,
      //   new MaterialPageRoute(builder: (context) => LanguageScreen()),
      // );
    }
  }

  // void _checkIfLoggedIn() async{    ///Uncomment it
  //
  //
  //   var url = "${APIConstants.API_BASE_URL_DEV}/api/setting";
  //   Dio dio = new Dio();
  //   var response = await dio.get(url);
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   localStorage.setInt("order_status",response.data["order_status"] );
  //   localStorage.setInt("branch_status",response.data["branch_status"] );
  //   if(response.data["status"] != 0) {
  //     // check if token is there
  //     var token = localStorage.getString('token');
  //     var branchID = localStorage.getString('branchId');
  //     if (token != null && branchID != null) {
  //       setState(() {
  //         _isLoggedIn = true;
  //         print("User Is Logged In");
  //         _gotoMainpage();
  //       });
  //     } else {
  //       print("User Is Not Logged In");
  //       Navigator.pushReplacement(
  //         context,
  //         new MaterialPageRoute(builder: (context) => GettingStartedScreen()),
  //       );
  //     }
  //   }
  //   else{
  //     Navigator.pushReplacement(
  //       context,
  //       new MaterialPageRoute(builder: (context) => AppSettings()),
  //     );
  //   }
  // }               ///Uncomment it

  // if (!prefs.containsKey('userData')) async => false;

//  checkLoginStatus() async {
//    final prefs = await SharedPreferences.getInstance();
//    if (prefs.getString('access_token') == null) {
//      Navigator.pushReplacement(
//        context,
//        new MaterialPageRoute(builder: (context) => LoginPage()),
//      );
//    }
//    final extractedUserData =
//    json.decode(prefs.getString('userData')) as Map<String, Object>;
//    final expiryDate = DateTime.parse(extractedUserData['expires_in']);
//
//    if (expiryDate.isBefore(DateTime.now())) {
//      return false;
//    }
//  }

  networkChecked() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return 'No Network Connection! Connected to Mobile Network';
      print("Connected to Mobile Network");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected to WiFi");
      return 'No WiFi Connection! Please Connected to WiFi';
    } else {
      isOffline = false;
      showNoNetworkAlertDialog(context);
      print("Unable to connect. Please Check Internet Connection");
    }
  }

  Future<void> showNoNetworkAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Connection Alert!'),
          content: Text('Unable to connect. Please Check Internet Connection'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
//                Navigator.pushReplacement(
//                  context,
//                  new MaterialPageRoute(builder: (context) => MainScreen()),
//                );
              },
            ),
          ],
        );
      },
    );
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  void _gotoMainpage() {
    // Navigator.pushReplacement(
    //   context,
    //   new MaterialPageRoute(builder: (context) => MainScreen(0)),
    // );
  }

  // void _gotoLoginPage(){
  //   Navigator.pushReplacement(
  //     context,
  //     new MaterialPageRoute(builder: (context) => LoginPage()),
  //   );
  //
  // }

  //------------------------------------------------------------------------------
//  void _handleTapEvent() async {
//    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
//    if (this.mounted) {
//      setState(() {
//        if (isLoggedIn != null && isLoggedIn) {
//          Navigator.pushReplacement(
//            context,
//            new MaterialPageRoute(builder: (context) => LocationPage()),
//          );
//        } else {
//          Navigator.pushReplacement(
//            context,
//            new MaterialPageRoute(builder: (context) => LoginPage()),
//          );
//        }
//      });
//    }
//  }
//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(color: Color(0xFF1BCFFF)),
      //decoration: new BoxDecoration(color: Colors.black26),
      child: new Center(
        child: Container(
         width: 250,
         height: 250,
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imgLogo),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}