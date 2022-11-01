import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization_master/classes/constant.dart';
import 'package:flutter_localization_master/pages/all_activities_list.dart';
import 'package:flutter_localization_master/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'favorite_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  //final Datum fooddata;
  final selectedPage;

  const MainScreen({super.key, required this.selectedPage});

  //const MainScreen({super.key, required this.selectedPage});
  //MainScreen({this});

  @override
  _MainScreenState createState() => _MainScreenState(selectedPage);
}

class _MainScreenState extends State<MainScreen> {
  final selectedPage;
  bool _isLoggedIn = false;
  var arLang = "Ar";
  var lang;
  var title;
  var _sysLng;
  var langChanged;
  var totalCount = '';
  var customerId;
  bool profilePage = false;
  int currentTab = 0;
  late String branch;
  // Pages

  late HomeScreen homePage;
  late FavScreen favScreen;
  late Accounts accounts;
  late AllActivitiesList allActivitiesList;
  //VendorScreen vendorScreen;
  // MyProfilePage profilePage;

  List<Widget>? pages;
  List<String>? titleName;
  late Widget currentPage;
  bool isloggedin = false;
  bool isVisible = true;

  _MainScreenState(this.selectedPage);



  _checkIfLoggedIn() async {
    homePage = HomeScreen();
    allActivitiesList = AllActivitiesList();
    //listingScreen = ListingScreen();
    favScreen = FavScreen();
    //newsScreen = NewsScreen();
    accounts = Accounts();
    //vendorScreen = VendorScreen();
    //profilePage = null;//ProfilePage();
    pages = [homePage,allActivitiesList, favScreen, accounts];
    titleName = [
      'Categories',
      "All Activities",
      'Favorites',
      "Account",
    ];
  }

  // Future<dynamic> _getCartQuantity() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   customerId = localStorage.getString('userID');
  //
  //   var url = APIConstants.API_BASE_URL_DEV + "/addToCart?UserId=$customerId";
  //   Map<String, String> requestHeaders = {
  //     //'Content-type': 'application/json',
  //     //'Accept': 'application/json',
  //     'x-api-key': '987654',
  //     //'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZmMjc2ZGU3YTI1YWE3MDlmOTdiYjcwZDllODY3ZGNjNzllNWRjMzJmOGZlZjNlNWQ1YzhlMzM5YTU5ZjMyNTU2YWNlZWM1YTdlZDc3MjY0In0.eyJhdWQiOiIyIiwianRpIjoiNmYyNzZkZTdhMjVhYTcwOWY5N2JiNzBkOWU4NjdkY2M3OWU1ZGMzMmY4ZmVmM2U1ZDVjOGUzMzlhNTlmMzI1NTZhY2VlYzVhN2VkNzcyNjQiLCJpYXQiOjE1ODA1NDM5ODUsIm5iZiI6MTU4MDU0Mzk4NSwiZXhwIjoxNjEyMTY2Mzg1LCJzdWIiOiIxMzIiLCJzY29wZXMiOltdfQ.h33_EIU37oXVwrBR3bU6Y7NzyoM4m1wue-09NkDOh4AEimZ9mjjoqxU2fvGEZ_Bo-o6sE5hNg_84bJ-WctedsnoEdwNSPt1O_1SWIrIFhyU5vvv1i9HyBIKx_l4uZLcC-C52TxxvO2awQrrDHPxcbAsyqqa7Z3jh02dAN91r-6Oe0XaH6OV-FabwSMdsWh028GxuIzJwATfHA_zPfDtIquG1TBLc7Q9cFOzlio7IOy3tOLCxVL4f_vt-aOwVF0C0M_eTgk8znI7nTpWk3TgKN_OjRegxbkSGXrS59SIMNZUhMBI1j1vmzSFmRlpEZ8vj5csFxnmTv9oT5tLviD06y8TIISHifpUMI4z2o4rg_qFQbHTAkf37pw2TCfsbzL5sIWMFwWNvbpeKmplurcsnqbzcXl7STqrHftWEwxz6a4Cjrt2fCcxWAkS3CzraANhMkDFuS9oaRqLGfGsZytOZVLTYzQi3HanEip_NqhtEDLhkiEZ6LSJg9CSkk9q9gjruM3zs-l_GijkwJZpdgHwb06SXQb1hF8sS-pcXMwKHU-nF9zKoYZYjodSLaawFtNleylQqZO1mg9gK0XEoMHqm1NXdJH54mqSjoIKmDtKPbmGINzERRB6Cls0pHjC5Z82JBZ9g7xwmOJbMGdN7i2rZhOzs4Mq-eT85nsP2-SNPiJE'
  //   };
  //   final response = await http.get(url, headers: requestHeaders);
  //   //final List<FavoriteItem> favProducts = [];
  //   final sliderData = json.decode(response.body);
  //   print("Numbers of items in cart are->>>>>> $sliderData");
  //   final qauntityData = sliderData['CartQuantity'];
  //   //List dataBanner = new List();
  //   //var dataLength = bannerImgData.length;
  //   // for (int i = 0; i < dataLength; i++) {
  //   //   dataBanner.add(bannerImgData[i]);
  //   // }
  //   //var favProd = favData['product'];
  //   // print('favorite Product Name - $favProd');
  //
  //   if (!mounted) return;
  //   setState(() {
  //     if (qauntityData != null) {
  //       totalCount = qauntityData;
  //     }
  //
  //     // bannerData.addAll(dataBanner);
  //     // images = bannerData;
  //     // isLoading = false;
  //   });
  //
  //   //print('data isss $favData["data"]');
  //   // if (totalCount == null) {
  //   //   return;
  //   // }
  //   // _favorite = favProducts;
  // }

  @override
  initState() {
    //_getCartQuantity();
    print('This is inside the initState In');
    homePage = HomeScreen(); //HomePage(widget.foodModel);
    allActivitiesList = AllActivitiesList();
    // listingScreen = ListingScreen();
    // mainHomeScreen = MainHomeScreen();
    // newsScreen = NewsScreen();
    favScreen = FavScreen();
    accounts = Accounts();
    //vendorScreen = VendorScreen();
    //profilePage = null;//ProfilePage();
    pages = [homePage,allActivitiesList, favScreen, accounts];
    titleName = [
      'Categories',
      "All Activities",
      'Favorites',
      "Account",
    ];

    //_checkIfLoggedIn();
    super.initState();

    if (selectedPage == 2) {
      currentPage = homePage;
      title = titleName![2];
    } else {
      currentPage = homePage;
      currentTab = 0;
      title = titleName![2];
    }
    _isIfLoggedIn();
  }

  // @override
  // void didChangeDependencies() {
  //   //_counter = Provider.of<int>(context);
  //   _getCartQuantity();
  //   print('didChangeDependencies(), counter = $totalCount');
  //   super.didChangeDependencies();
  // }

  void _isIfLoggedIn() async {
    print('This is inside the Logged In');
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    //totalCount = localStorage.getString('CartQuantity');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
        //_getCartQuantity();
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
  Widget build(BuildContext context) {
    print('Build Method call');
    //_getCartQuantity();
    //_sysLng = ui.window.locale.languageCode;
    //print("SYSTEM LANGUAGE IS ======>>>>$_sysLng");
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
        return exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            // leading: GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       if (User.userData.lang == "en") {
            //         setState(() {
            //           User.userData.lang = "ar";
            //         });
            //         print("Selected languages: ${User.userData.lang}");
            //         changeLanguage("ar", context);
            //       } else {
            //         setState(() {
            //           User.userData.lang = "en";
            //         });
            //         print("Selected languages: ${User.userData.lang}");
            //         changeLanguage("en", context);
            //       }
            //     });
            //   },
            //   child: Container(
            //     padding: EdgeInsets.only(
            //         left: MediaQuery.of(context).size.width * .02,
            //         top: 15,
            //         right: MediaQuery.of(context).size.width * .02),
            //     width: MediaQuery.of(context).size.width * .23,
            //     height: MediaQuery.of(context).size.height * .08,
            //     color: Colors.white,
            //     child: Text(
            //       getTranslated(context, "buttonTitle"),
            //       style: TextStyle(
            //           color: Theme.of(context).primaryColor, fontSize: 14),
            //     ),
            //     // decoration: BoxDecoration(
            //     //     image: DecorationImage(
            //     //         image: AssetImage("images/homegif.gif"),
            //     //         fit: BoxFit.contain)),
            //   ),
            // ),
            title: Text(
              "Qactivity",
              style: TextStyle(
                fontFamily: "cairo",
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor:Color(0xFF1BCFFF),
            centerTitle: true,
            // leading: new IconButton(
            //     icon: Platform.isIOS ? new Icon(Icons.arrow_back_ios) : new Icon(Icons.arrow_back),
            //     onPressed: (){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => MainScreen(0)),
            //       );
            //     }
            // ),
            automaticallyImplyLeading: false, // hides leading widget
            // title: Text(
            //   translator.translate('Departments'),
            //   style: TextStyle(
            //     color: Colors.white,
            //   ),
            // ),
            //backgroundColor: Theme.of(context).bottomAppBarColor,
            actions: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                     height: currentTab == 3
//                         ? MediaQuery.of(context).size.height * .08
//                         : 150.0,
//                     width: currentTab == 3
//                         ? MediaQuery.of(context).size.width * .2
//                         : 30.0,
//                     child: GestureDetector(
//                         onTap: () {
// //                  _isLoggedIn? Navigator.of(context).push(new MaterialPageRoute(
// //                      builder: (BuildContext context) => CartPage()
// //                  )) : null;
//
//                           if (_isLoggedIn == true) {
//                             if (currentTab == 3) {
//                               Navigator.of(context).push(
//                                 BlockBuildPageRoute(
//                                     transition: PageTransition
//                                         .FadeTrans, //not specifying transition uses CupertinoPageTransition
//                                     widget: AddList()),
//                               );
//
//                               // Navigator.of(context).push(MaterialPageRoute(
//                               //     builder: (BuildContext context) =>
//                               //         AddList()));
//                             } else {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (BuildContext context) =>
//                                       CartScreen()));
//                             }
//                           } else {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (BuildContext context) =>
//                                     LoginPage()));
//                             //_guestAlertForAddtoCart();
//                           }
//                         },
//
//                         /// badge on Cart code --
//                         child: currentTab == 3
//                             ? Container(
//                           width: MediaQuery.of(context).size.width * .3,
//                           height: MediaQuery.of(context).size.height * .1,
//                           decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Center(
//                               child: Text(
//                                 getTranslated(context, 'add list'),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.clip,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ),
//                               )),
//                         )
//                             : new Stack(
//                           children: <Widget>[
//                             new IconButton(
//                               icon: new Icon(
//                                 Icons.shopping_cart,
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                               onPressed: null,
//                               iconSize: 27,
//                             ),
//                             totalCount == ''
//                                 ? new Container()
//                                 : new Positioned(
//                                 left: 3,
//                                 child: new Stack(
//                                   children: <Widget>[
// //                                new Icon(Icons.brightness_1,
// //                                    size: 19.0,
// //                                    color: Theme.of(context).accentColor),
//                                     Container(
//                                       height: 20.0,
//                                       width: 20.0,
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: new Center(
//                                             child: new Text(
//                                               "$totalCount",
//                                               style: new TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 11.0,
//                                                   fontFamily: "cairo",
//                                                   fontWeight:
//                                                   FontWeight.w500),
//                                             )),
//                                       ),
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.all(
//                                               Radius.circular(
//                                                   100.0)),
//                                           color: Colors.red),
//                                     ),
//                                   ],
//                                 )),
//                           ],
//                         ))),
//               ),
            ]
          //elevation: 0.0,
          // centerTitle: true,
        ),
        //backgroundColor: mainColor,
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: AnimatedContainer(
          //color: Theme.of(context).primaryColor,
          duration: Duration(milliseconds: 500),
          //height: isVisible ? 56.0 : 0.0,
          child: Wrap(children: <Widget>[
            BottomNavigationBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              iconSize: 30.0,
              selectedItemColor: blueColor,
              unselectedItemColor: greyColor.withOpacity(0.3),
              currentIndex: currentTab,
              onTap: (index) {
                setState(() {
                  currentTab = index;
                  currentPage = pages![index];
                  title = titleName![index];
                });
              },
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                // BottomNavigationBarItem(
                //   //backgroundColor: Colors.white,
                //   icon: Image.asset(
                //     "images/hanger.png",
                //     width: 30,
                //     height: 30,
                //     color: currentTab == 0 ? mainColor : Colors.grey,
                //   ),
                //   title: Text(
                //     'Categories',
                //   ),
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.supervised_user_circle,
                //   ),
                //   title: Text(
                //     'Vendors',
                //   ),
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list_alt_outlined,
                  ),
                  label: "All Activities",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_rounded,
                  ),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people,
                  ),
                  label: 'Contact Us',
                ),
              ],
            ),
          ]),
        ),
        body: currentPage,
        // drawer: Drawer(
        //   // Add a ListView to the drawer. This ensures the user can scroll
        //   // through the options in the drawer if there isn't enough vertical
        //   // space to fit everything.
        //   child: ListView(
        //     // Important: Remove any padding from the ListView.
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       DrawerHeader(
        //         padding: EdgeInsets.all(5.0),
        //         child: _isLoggedIn
        //             ? Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   new CircleAvatar(
        //                     radius: 60.0,
        //                     backgroundColor: Colors.black,
        //                     child: new Image.asset(
        //                       'images/applogo.png',
        //                     ), //For Image Asset
        //                   ),
        //                   Text('Welcome',
        //                       style: TextStyle(
        //                           color: Colors.white,
        //                           fontFamily: "cairo",
        //                           fontSize: 16.0)),
        //                 ],
        //               )
        //             : Text(
        //                 'Hello Guest',
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontFamily: "cairo",
        //                     fontSize: 16.0),
        //               ),
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).primaryColor,
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.supervised_user_circle_rounded),
        //         title: Text(translator.translate('Profile')),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Update the state of the app.
        //           // ...
        //           _isLoggedIn
        //               ? Navigator.of(context).push(new MaterialPageRoute(
        //                   builder: (BuildContext context) => MyProfilePage()))
        //               : Navigator.of(context).push(new MaterialPageRoute(
        //                   builder: (BuildContext context) => LoginPage()));
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.add_box),
        //         title: Text(translator.translate("add list")),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Update the state of the app.
        //           // ...
        //           _isLoggedIn
        //               ? Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (BuildContext context) => AddList()))
        //               : Navigator.of(context).push(new MaterialPageRoute(
        //                   builder: (BuildContext context) => LoginPage()));
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.local_shipping),
        //         title: Text(translator.translate("order")),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Update the state of the app.
        //           // ...
        //           _isLoggedIn
        //               ? Navigator.of(context).push(new MaterialPageRoute(
        //                   builder: (BuildContext context) => Orders()))
        //               : Navigator.of(context).push(new MaterialPageRoute(
        //                   builder: (BuildContext context) => LoginPage()));
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.account_box),
        //         title: Text(translator.translate('About Us')),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Update the state of the app.
        //           // ...
        //           Navigator.of(context).push(new MaterialPageRoute(
        //               builder: (BuildContext context) => AboutUs()));
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.lock),
        //         title: Text(translator.translate('Privacy Policy')),
        //         onTap: () {
        //           Navigator.pop(context);
        //           // Update the state of the app.
        //           // ...

        //           Navigator.of(context).push(new MaterialPageRoute(
        //               builder: (BuildContext context) => PrivacyPolicy()));
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.loyalty),
        //         title: Text(translator.translate('Terms and Conditions')),
        //         onTap: () {
        //           Navigator.pop(context);

        //           Navigator.of(context).push(new MaterialPageRoute(
        //               builder: (BuildContext context) => TermsCondition()));
        //           // Update the state of the app.
        //           // ...
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.language_sharp),
        //         title: Text(translator.translate('buttonTitle')),
        //         onTap: () async {
        //           langChanged = translator.translate('buttonTitle');
        //           print("Selected Language is =========>>>>>>$langChanged");
        //           SharedPreferences localStorage =
        //               await SharedPreferences.getInstance();
        //           localStorage.setBool('isLangArabic', true);
        //           localStorage.setString('selectedLanguage', arLang);
        //           localStorage.setString('LangSelect', langChanged);
        //           setState(() {
        //             translator.setNewLanguage(
        //               context,
        //               newLanguage:
        //                   translator.currentLanguage == 'ar' ? 'en' : 'ar',
        //               remember: true,
        //               restart: true,
        //             );
        //           });
        //           print("Changed Language To Arabic");
        //         },
        //       ),
        //       _isLoggedIn
        //           ? ListTile(
        //               leading: Icon(Icons.logout),
        //               title: Text(translator.translate('Log Out')),
        //               onTap: () {
        //                 Navigator.pop(context);
        //                 _logoutFromTheApp(context);
        //                 // Navigator.of(context).push(new MaterialPageRoute(
        //                 //     builder: (BuildContext context) => ContactUs()));
        //                 // Update the state of the app.
        //                 // ...
        //               },
        //             )
        //           : Padding(
        //               padding: const EdgeInsets.all(30.0),
        //               child: FlatButton(
        //                 color: Colors.redAccent,
        //                 textColor: Colors.white,
        //                 disabledColor: Colors.grey,
        //                 disabledTextColor: Colors.black,
        //                 padding: EdgeInsets.all(8.0),
        //                 splashColor: Colors.blueAccent,
        //                 onPressed: () {
        //                   Navigator.of(context).push(MaterialPageRoute(
        //                       builder: (BuildContext context) => LoginPage()));
        //                 },
        //                 child: Text(
        //                   translator.translate("Login"),
        //                   style: TextStyle(
        //                     fontSize: 20.0,
        //                     fontFamily: "cairo",
        //                   ),
        //                 ),
        //               ),
        //             ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  // void _logoutFromTheApp(context) {
  //   AppSharedPreferences.clear();
  //   Navigator.pushReplacement(
  //     context,
  //     new MaterialPageRoute(builder: (context) => LanguageScreen()),
  //   );
  // }

  void checkIsvisible(bool value) {
    setState(() {
      isVisible = value;
      print("value iss $value");
    });
  }
}