import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localization_master/classes/app_shared_preferences.dart';
import 'package:flutter_localization_master/classes/constant.dart';
import 'package:flutter_localization_master/localization/language_constants.dart';
import 'package:flutter_localization_master/pages/explore_screen.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:convert';
// import 'package:flutter_boom_menu/flutter_boom_menu.dart';

import 'login_screen.dart';

class Accounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Accounts();
  }
}

class _Accounts extends State<Accounts> with SingleTickerProviderStateMixin {
  bool _isLoggedIn = false;
  late Animation<double> _animation;
  late AnimationController _animationController;
  late ScrollController scrollController;
  bool scrollVisible = true;
  bool isVisible = true;
  void _isIfLoggedIn() async {
    print('This is inside the Logged In');
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    //totalCount = localStorage.getString('CartQuantity');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
        //_getCartItemCount();

        //print("User Is Logged In");
        // _gotoMainpage();
      });
    } else {
      print("User Is Not Logged In");
//      Navigator.pushReplacement(
//        context,
//        new MaterialPageRoute(builder: (context) => LoginPage()),
//      );
    }
  }

  @override
  void initState() {
    super.initState();
    //_isIfLoggedIn();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 260),
    // );

    // final curvedAnimation =
    //     CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    // _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    // scrollController = ScrollController()
    //   ..addListener(() {
    //     setDialVisible(scrollController.position.userScrollDirection ==
    //         ScrollDirection.forward);
    //   });
  }

  // void setDialVisible(bool value) {
  //   setState(() {
  //     scrollVisible = value;
  //   });
  // }

  _callNumber() async{
    const number = "+97470483444"; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  _sendingMails() async {
    var url = Uri.parse("mailto:info@hsd-qatar.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var heigth = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: width * .07),
        // child: BoomMenu(
        //   animatedIcon: AnimatedIcons.menu_close,
        //   animatedIconTheme: IconThemeData(size: 20.0),
        //   //child: Icon(Icons.add),
        //   onOpen: () => print('OPENING DIAL'),
        //   onClose: () => print('DIAL CLOSED'),
        //   //scrollVisible: scrollVisible,
        //   overlayColor: Colors.black,
        //   overlayOpacity: 0.7,
        //   children: [
        //     // MenuItem(
        //     //   child: Icon(Icons.call, color: Colors.black),
        //     //   title: 'Call us',
        //     //   titleColor: Colors.white,
        //     //   subtitle: "0900-8000",
        //     //   subTitleColor: Colors.white,
        //     //   backgroundColor: Colors.deepOrange,
        //     //   onTap: () => print('FIRST CHILD'),
        //     // ),
        //     // MenuItem(
        //     //   child: Icon(Icons.email, color: Colors.black),
        //     //   title: 'Email Us',
        //     //   titleColor: Colors.white,
        //     //   subtitle: "info@hsdmedia.com",
        //     //   subTitleColor: Colors.white,
        //     //   backgroundColor: Colors.green,
        //     //   onTap: () => print('SECOND CHILD'),
        //     // ),
        //     // MenuItem(
        //     //   child: Icon(Icons.contact_mail, color: Colors.black),
        //     //   title: "contact_us",
        //     //   titleColor: Colors.white,
        //     //   subtitle: "info@hsdmedia.com",
        //     //   subTitleColor: Colors.white,
        //     //   backgroundColor: Colors.blue,
        //     //   onTap: () => print('THIRD CHILD'),
        //     // ),
        //   ],
        // ),
      ),
      body: GestureDetector(
        onTap: () {
          _animationController.reverse();
        },
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * .99,
                  height: heigth * .3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("images/desert.png"),
                          colorFilter: new ColorFilter.mode(
                              greyColor.withOpacity(0.3), BlendMode.darken),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.home_work),
              title: Text(
                "HSD Media & Advertising",
              ),
              onTap: () {
                // Navigator.pop(context);
                // Update the state of the app.
                // ...
                // _isLoggedIn
                //     ? Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => ExploreScreen()))
                //     : Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) => LoginScreen()));
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.call),
            //   title: Text(
            //     "+974-70483444",
            //   ),
            //   onTap: () {
            //     _callNumber();
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.whatsapp),
            //   title: Text(
            //     "+974-50066668",
            //   ),
            //   onTap: () {
            //     //Navigator.pop(context);
            //     // Update the state of the app.
            //     // ...
            //     // _isLoggedIn
            //     //     ? Navigator.of(context).push(new MaterialPageRoute(
            //     //     builder: (BuildContext context) => LoginScreen()))
            //     //     : Navigator.of(context).push(new MaterialPageRoute(
            //     //     builder: (BuildContext context) => LoginScreen()));
            //     var url = Uri.parse("https://wa.me/+97450066668?text=Hello");
            //     launchUrl(url);
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                "Send Us Email",
              ),
              onTap: () {
                //Navigator.pop(context);
                // Update the state of the app.
                // ...
                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) => LoginScreen()));
                _sendingMails();
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.lock),
            //   title: Text(
            //     getTranslated(context, "Privacy Policy"),
            //   ),
            //   onTap: () {
            //     // Navigator.pop(context);
            //     // Update the state of the app.
            //     // ...

            //     Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext context) => PrivacyPolicy()));
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.loyalty),
            //   title: Text(
            //     getTranslated(context, "Terms and Conditions"),
            //   ),
            //   onTap: () {
            //     // Navigator.pop(context);

            //     Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext context) => TermsCondition()));
            //     // Update the state of the app.
            //     // ...
            //   },
            // ),

            ListTile(
              leading: Icon(Icons.add_location_sharp),
              title: Text(
                "Office# 294, 29th Floor, Marina Twin Tower B, Lusail City, Doha-Qatar.",
              ),
              onTap: () {
                // Navigator.pop(context);

                // Navigator.of(context).push(new MaterialPageRoute(
                //     builder: (BuildContext context) => LoginScreen()));
                // Update the state of the app.
                // ...
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.language_sharp),
            //   title: Text(
            //     "buttonTitle",
            //   ),
            //   onTap: () async {
            //     // setState(() {
            //     //   if (User.userData.lang == "en") {
            //     //     setState(() {
            //     //       User.userData.lang = "ar";
            //     //     });
            //     //     print("Selected languages: ${User.userData.lang}");
            //     //     changeLanguage("ar", context);
            //     //   } else {
            //     //     setState(() {
            //     //       User.userData.lang = "en";
            //     //     });
            //     //     print("Selected languages: ${User.userData.lang}");
            //     //     changeLanguage("en", context);
            //     //   }
            //     // });
            //     print("Changed Language To Arabic");
            //   },
            // ),
            // _isLoggedIn
            //     ? ListTile(
            //   leading: Icon(Icons.logout),
            //   title: Text(
            //     getTranslated(context, "Log Out"),
            //   ),
            //   onTap: () {
            //     //  Navigator.pop(context);
            //     _logoutFromTheApp(context);
            //     // Navigator.of(context).push(new MaterialPageRoute(
            //     //     builder: (BuildContext context) => ContactUs()));
            //     // Update the state of the app.
            //     // ...
            //   },
            // )
            //     : Row(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(bottom: 10, left: 15),
            //       width: MediaQuery.of(context).size.width * .5,
            //       height: MediaQuery.of(context).size.height * .08,
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(16)),
            //       child: FlatButton(
            //         color: Theme.of(context).primaryColor,
            //         textColor: Colors.white,
            //         disabledColor: Colors.grey,
            //         disabledTextColor: Colors.black,
            //         padding: EdgeInsets.all(8.0),
            //         splashColor: Theme.of(context).accentColor,
            //         onPressed: () {
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (BuildContext context) =>
            //                   LoginScreen()));
            //         },
            //         child: Text(
            //           getTranslated(context, "Login"),
            //           style: TextStyle(
            //             fontSize: 20.0,
            //             fontFamily: "cairo",
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void _logoutFromTheApp(context) {
    AppSharedPreferences.clear();
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
