// import 'package:flutter/material.dart';
// import 'package:flutter_localization_master/classes/language.dart';
// import 'package:flutter_localization_master/localization/language_constants.dart';
// import 'package:flutter_localization_master/main.dart';
// import 'package:flutter_localization_master/router/route_constants.dart';
//
// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   void _changeLanguage(Language language) async {
//     Locale _locale = await setLocale(language.languageCode);
//     MyApp.setLocale(context, _locale);
//   }
//
//   void _showSuccessDialog() {
//     showTimePicker(context: context, initialTime: TimeOfDay.now());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(getTranslated(context, 'home_page')),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: DropdownButton<Language>(
//               underline: SizedBox(),
//               icon: Icon(
//                 Icons.language,
//                 color: Colors.white,
//               ),
//               onChanged: (Language language) {
//                 _changeLanguage(language);
//               },
//               items: Language.languageList()
//                   .map<DropdownMenuItem<Language>>(
//                     (e) => DropdownMenuItem<Language>(
//                       value: e,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[
//                           Text(
//                             e.flag,
//                             style: TextStyle(fontSize: 30),
//                           ),
//                           Text(e.name)
//                         ],
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: _drawerList(),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         child: _mainForm(context),
//       ),
//     );
//   }
//
//   Form _mainForm(BuildContext context) {
//     return Form(
//       key: _key,
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height / 4,
//             child: Center(
//               child: Text(
//                 getTranslated(context, 'personal_information'),
//                 // DemoLocalization.of(context).translate('personal_information'),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           TextFormField(
//             validator: (val) {
//               if (val.isEmpty) {
//                 return getTranslated(context, 'required_field');
//                 // return DemoLocalization.of(context).translate('required_fiedl');
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: getTranslated(context, 'name'),
//               hintText: getTranslated(context, 'name_hint'),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             validator: (val) {
//               if (val.isEmpty) {
//                 return getTranslated(context, 'required_field');
//               }
//               return null;
//             },
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               labelText: getTranslated(context, 'email'),
//               hintText: getTranslated(context, 'email_hint'),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: getTranslated(context, 'date_of_birth')),
//             onTap: () async {
//               FocusScope.of(context).requestFocus(FocusNode());
//               await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime(DateTime.now().year),
//                 lastDate: DateTime(DateTime.now().year + 20),
//               );
//             },
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           MaterialButton(
//             onPressed: () {
//               if (_key.currentState.validate()) {
//                 _showSuccessDialog();
//               }
//             },
//             height: 50,
//             shape: StadiumBorder(),
//             color: Theme.of(context).primaryColor,
//             child: Center(
//               child: Text(
//                 getTranslated(context, 'submit_info'),
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Container _drawerList() {
//     TextStyle _textStyle = TextStyle(
//       color: Colors.white,
//       fontSize: 24,
//     );
//     return Container(
//       color: Theme.of(context).primaryColor,
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             child: Container(
//               height: 100,
//               child: CircleAvatar(),
//             ),
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.info,
//               color: Colors.white,
//               size: 30,
//             ),
//             title: Text(
//               getTranslated(context, 'about_us'),
//               style: _textStyle,
//             ),
//             onTap: () {
//               // To close the Drawer
//               Navigator.pop(context);
//               // Navigating to About Page
//               Navigator.pushNamed(context, aboutRoute);
//             },
//           ),
//           ListTile(
//             leading: Icon(
//               Icons.settings,
//               color: Colors.white,
//               size: 30,
//             ),
//             title: Text(
//               getTranslated(context, 'settings'),
//               style: _textStyle,
//             ),
//             onTap: () {
//               // To close the Drawer
//               Navigator.pop(context);
//               // Navigating to About Page
//               Navigator.pushNamed(context, settingsRoute);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_localization_master/classes/constant.dart';
import 'package:flutter_localization_master/pages/activity_list_screen.dart';
import 'package:flutter_localization_master/router/route_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool searchActive = true;
  bool isCrossActive = false;
  // ignore: deprecated_member_use
  List departmentData = [];
  List finalData = [];
  List _searchResult = [];
  var arLang = "Ar";
  var totalCount = '';
  var lang;
  int column = 2;
  var langChanged;
  var _searchView = new TextEditingController();
  bool isUserVendor = false;
  var data = [
  {
  "id": 1,
  "name": "Sky Diving",
  "image": img5,
  "price":"550 QAR/Hour",
  "address":"Lusail City"
  },
  {
    "id": 5,
    "name": "Surfing",
    "image": img1,
    "price":"150 QAR/Hour",
    "address":"Pearl Qatar"
  },
  {
    "id": 7,
    "name": "Fishing",
    "image": img7,
    "price":"230 QAR/Hour",
    "address":"Marina Beach"
  },
  {
    "id": 8,
    "name": "Skate boarding",
    "image": img8,
    "price":"500 QAR/Hour",
    "address":"City Center"
  },
  {
    "id": 9,
    "name": "Desert Safari",
    "image": img9,
    "price":"530 QAR/Hour",
    "address":"Desert Area"
  },
  {
    "id": 10,
    "name": "Cycling",
    "image": img10,
    "price":"430 QAR/Hour",
    "address":"Al Sadd"
  },
  {
    "id": 11,
    "name": "Snorkeling",
    "image": img11,
    "price":"330 QAR/Hour",
    "address":"Sea Line"
  },
  {
    "id": 12,
    "name": "Motorsport",
    "image": img12,
    "price":"450 Qar/Hour",
    "address":"Lusail City"
  }
];

  // Future<dynamic> _getDepartmentData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   lang = localStorage.getString('selectedLanguage');
  //   langChanged = localStorage.getString('LangSelect');
  //   var geturl = APIConstants.API_BASE_URL_DEV + APIOperations.ListingDepartments;
  //   Map<String, String> requestHeaders = {
  //     //'Content-type': 'application/json',
  //     //'Accept': 'application/json',
  //     'x-api-key': '987654',
  //     //'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZmMjc2ZGU3YTI1YWE3MDlmOTdiYjcwZDllODY3ZGNjNzllNWRjMzJmOGZlZjNlNWQ1YzhlMzM5YTU5ZjMyNTU2YWNlZWM1YTdlZDc3MjY0In0.eyJhdWQiOiIyIiwianRpIjoiNmYyNzZkZTdhMjVhYTcwOWY5N2JiNzBkOWU4NjdkY2M3OWU1ZGMzMmY4ZmVmM2U1ZDVjOGUzMzlhNTlmMzI1NTZhY2VlYzVhN2VkNzcyNjQiLCJpYXQiOjE1ODA1NDM5ODUsIm5iZiI6MTU4MDU0Mzk4NSwiZXhwIjoxNjEyMTY2Mzg1LCJzdWIiOiIxMzIiLCJzY29wZXMiOltdfQ.h33_EIU37oXVwrBR3bU6Y7NzyoM4m1wue-09NkDOh4AEimZ9mjjoqxU2fvGEZ_Bo-o6sE5hNg_84bJ-WctedsnoEdwNSPt1O_1SWIrIFhyU5vvv1i9HyBIKx_l4uZLcC-C52TxxvO2awQrrDHPxcbAsyqqa7Z3jh02dAN91r-6Oe0XaH6OV-FabwSMdsWh028GxuIzJwATfHA_zPfDtIquG1TBLc7Q9cFOzlio7IOy3tOLCxVL4f_vt-aOwVF0C0M_eTgk8znI7nTpWk3TgKN_OjRegxbkSGXrS59SIMNZUhMBI1j1vmzSFmRlpEZ8vj5csFxnmTv9oT5tLviD06y8TIISHifpUMI4z2o4rg_qFQbHTAkf37pw2TCfsbzL5sIWMFwWNvbpeKmplurcsnqbzcXl7STqrHftWEwxz6a4Cjrt2fCcxWAkS3CzraANhMkDFuS9oaRqLGfGsZytOZVLTYzQi3HanEip_NqhtEDLhkiEZ6LSJg9CSkk9q9gjruM3zs-l_GijkwJZpdgHwb06SXQb1hF8sS-pcXMwKHU-nF9zKoYZYjodSLaawFtNleylQqZO1mg9gK0XEoMHqm1NXdJH54mqSjoIKmDtKPbmGINzERRB6Cls0pHjC5Z82JBZ9g7xwmOJbMGdN7i2rZhOzs4Mq-eT85nsP2-SNPiJE'
  //   };
  //   final response = await http.get(geturl, headers: requestHeaders);
  //   //final List<FavoriteItem> favProducts = [];
  //   final favData = json.decode(response.body);
  //   final deptData = favData['Data'];
  //   print("All Vendors by Department data ===========->>> $deptData");
  //   List dataDepart = new List();
  //   var dataLength = deptData.length;
  //   for (int i = 0; i < dataLength; i++) {
  //     dataDepart.add(deptData[i]);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _isLoading = false;
  //     departmentData.addAll(dataDepart);
  //     finalData = departmentData;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserVendor = getUserVendor();
    //_getDepartmentData();
    _checkIfLoggedIn();
    //data = finalData;
    //print("User Is Not Logged In ${data}");
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
        //_getCartItemCount();

        //print("User Is Logged In");
        // _gotoMainpage();
      });
    } else {
      //print("User Is Not Logged In ${finalData.length}");

//      Navigator.pushReplacement(
//        context,
//        new MaterialPageRoute(builder: (context) => LoginPage()),
//      );
    }
    var dataLength = data.length;
    for (int i = 0; i < dataLength; i++) {
      departmentData.add(data[i]);
    }
    setState(() {
      departmentData = finalData;
      print("User Is Not Logged In jafrey ${finalData.length}");
    });
  }

  Widget _createSearchView() {
    return new Container(
      width:MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(color: Colors.transparent,
          border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: new TextField(
        controller: _searchView,
        ///if you want to search by word by word just uncomment itٓ
        // onChanged: (search){
        //   _getFilterResult(search);
        // },
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: searchActive ?IconButton(
            icon: Icon(Icons.search_sharp),
            onPressed: () {
              //_getFilterResult(_searchview.text);
              var dataLength = data.length;
              for (int i = 0; i < dataLength; i++) {
                departmentData.add(data[i]);
                if(data[i]['name'] == _searchView.text){
                  _searchResult.add(data[i]);
                }
              }
              setState(() {
                _searchResult = data;
                print("User Is Not Logged In shahid ${_searchResult}");
              });
              // data.forEach((dataLength) {
              //   if (data[i].contains(_searchView.text) || userDetail.lastName.contains(_searchView.text))
              //     _searchResult.add(userDetail);
              // });
              _searchView.text = "";
              setState(() {
                isCrossActive = true;
                searchActive = false;
              });
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          ):IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                _searchView.text = "";
                //filterName = [];
                isCrossActive = false;
                searchActive = true;
              });
              //_getList();
            },
          ),
          hintText: "Search Your Activity!",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[100],
      //backgroundColor: Theme.of(context).accentColor,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   // leading: new IconButton(
      //   //     icon: Platform.isIOS ? new Icon(Icons.arrow_back_ios) : new Icon(Icons.arrow_back),
      //   //     onPressed: (){
      //   //       Navigator.push(
      //   //         context,
      //   //         MaterialPageRoute(builder: (context) => MainScreen(0)),
      //   //       );
      //   //     }
      //   // ),
      //   title: Text(
      //     translator.translate("Listing"),
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor:Theme.of(context).primaryColor,
      //   //elevation: 0.0,
      //   // centerTitle: true,
      // ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(column == 1 ? "Grid View" : "List View",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (column == 1) {
                              column = 2;
                            } else {
                              column = 1;
                            }
                          });
                        },
                        child: Icon(column == 1 ? Icons.grid_on : Icons.list,size: 32),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 10,bottom: 10,top: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             if (column == 1) {
                //               column = 2;
                //             } else {
                //               column = 1;
                //             }
                //           });
                //         },
                //         child: Icon(column == 1 ? Icons.grid_on : Icons.list),
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //     ],
                //   ),
                // ),
                Container(
                  // padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: GridView.count(
                    // shrinkWrap: true,
                    crossAxisCount: column,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: column == 1 ? 2 : 1.1,
                    // physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      data.length,
                          (index) => InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ProductDetailScreen(
                          //         id: filterName[index]['Id'],
                          //         title: filterName[index]['NameEn'],
                          //         titleAr: filterName[index]['NameAr'],
                          //         price: filterName[index]['Price'],
                          //         shortDes: filterName[index]['ShortDescriptionEn'],
                          //         shortDesAr: filterName[index]['ShortDescriptionAr'],
                          //         description: filterName[index]['DescriptionEn'],
                          //         descriptionAr: filterName[index]['DescriptionAr'],
                          //         userId: filterName[index]['UserId'],
                          //         vendorId: filterName[index]['VendorId'],
                          //         inStock: filterName[index]['StockStatus'],
                          //       ),
                          //     ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ActivityList(
                                    id:data[index]['id'],
                                    name: data[index]['name'],
                                    image: AssetImage(data[index]['image'] as String),
                                    price: data[index]['price'],
                                    address: data[index]['address'],
                                  )));
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 10, left: 12, right: 12, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                image: DecorationImage(
                                    image:AssetImage(data[index]['image'] as String),
                                    // data[index]['image'].toString().isEmpty
                                    //     ? AssetImage(data[index]['image'])
                                    //     : Image.asset(data[index]['image']), solution for - NetworkImage(activityList[index]['img']),
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                    fit: BoxFit.fill),
                                boxShadow: [
                                  BoxShadow(
                                      color: greyColor,
                                      blurRadius: 3,
                                      spreadRadius: 1)
                                ]),
                            child: Center(
                              child: Text(data[index]["name"] as String,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      //controller: _scrollController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      // return GridView.builder(

      // drawer: Drawer(
      //   // Add a ListView to the drawer. This ensures the user can scroll
      //   // through the options in the drawer if there isn't enough vertical
      //   // space to fit everything.
      //   child: ListView(
      //     // Important: Remove any padding from the ListView.
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         child: _isLoggedIn
      //             ? Text('Hello Shahid',
      //             style: TextStyle(color: Colors.white, fontSize: 22.0))
      //             : Text(
      //           'Hello Guest',
      //           style: TextStyle(color: Colors.white, fontSize: 25.0),
      //         ),
      //         decoration: BoxDecoration(
      //           color: Theme.of(context).primaryColor,
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.account_box),
      //         title: Text('About Us'),
      //         // onTap: () {
      //         //   Navigator.pop(context);
      //         //   // Update the state of the app.
      //         //   // ...
      //         //   Navigator.of(context).push(new MaterialPageRoute(
      //         //       builder: (BuildContext context) => AboutUs()));
      //         // },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.lock),
      //         title: Text('Privacy Policy'),
      //         // onTap: () {
      //         //   Navigator.pop(context);
      //         //   // Update the state of the app.
      //         //   // ...
      //         //
      //         //   Navigator.of(context).push(new MaterialPageRoute(
      //         //       builder: (BuildContext context) => PrivacyPolicy()));
      //         // },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.loyalty),
      //         title: Text('Terms and Conditions'),
      //         // onTap: () {
      //         //   Navigator.pop(context);
      //         //
      //         //   Navigator.of(context).push(new MaterialPageRoute(
      //         //       builder: (BuildContext context) => TermConditions()));
      //         //   // Update the state of the app.
      //         //   // ...
      //         // },
      //       ),
      //       _isLoggedIn
      //           ? ListTile(
      //         leading: Icon(Icons.language_sharp),
      //         title: Text(translator.translate('buttonTitle')),
      //         onTap: () async {
      //           SharedPreferences localStorage = await SharedPreferences.getInstance();
      //           localStorage.setBool('isLangArabic', true);
      //           localStorage.setString('selectedLanguage', arLang );
      //           setState(() {
      //             translator.setNewLanguage(
      //               context,
      //               newLanguage: translator.currentLanguage == 'ar' ? 'en' : 'ar',
      //               remember: true,
      //               restart: true,
      //             );
      //           });
      //           //Navigator.pop(context);
      //           // _changeLanguage(Language language);
      //           print("Changed Language To Arabic");
      //           //
      //           //   Navigator.of(context).push(new MaterialPageRoute(
      //           //       builder: (BuildContext context) => ContactUs()));
      //           //   // Update the state of the app.
      //           //   // ...
      //         },
      //       ): Text(''),
      //       _isLoggedIn
      //           ? ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text('Log Out'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           _logoutFromTheApp(context);
      //           // Navigator.of(context).push(new MaterialPageRoute(
      //           //     builder: (BuildContext context) => ContactUs()));
      //           // Update the state of the app.
      //           // ...
      //         },
      //       )
      //           : Text(''),
      //     ],
      //   ),
      // ),
    );
  }

// void _logoutFromTheApp(context) {
//   AppSharedPreferences.clear();
//   Navigator.pushReplacement(
//     context,
//     new MaterialPageRoute(builder: (context) => LoginPage()),
//   );
// }
}


