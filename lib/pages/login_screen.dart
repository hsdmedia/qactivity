import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/router/route_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../classes/constant.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  bool isOffline = false;
  bool showpassword = true;
  bool isUserVendor = false;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  @override
  void initState() {
    // TODO: implement initState
    networkChecked();
    super.initState();
    isUserVendor = getUserVendor();
    emailController.text = "adbd@gmail.com";
    passwordController.text = "123456789";
    print('isUserVendor ===>>$isUserVendor');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  showPassword() {
    if (showpassword == true) {
      setState(() {
        showpassword = false;
      });
    } else {
      setState(() {
        showpassword = true;
      });
    }
  }

  TextStyle style = TextStyle(fontFamily: "cairo", fontSize: 18.0);

  late SharedPreferences sharedPreferences;

  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //GlobalKey<FormState> _key = new GlobalKey();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _validate = false;

  //LoginRequestData _loginData = LoginRequestData();
  bool _obscureText = true;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  /// This one commented
  ///

  signIn() async {
    print("SUCCESSFULLY LOGGED IN Message 1");
    setState(() {
      _isLoading = true;
    });
    var urlFinal = Uri.parse("https://hsd-qatar.com/qactivity/login");
    final urlToCall = "https://hsd-qatar.com/qactivity/login";
    Map<String, String> userData = {
      "email": "from@postman",
      "password": "newpass"
    };
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/x-www-form-urlencoded'//'application/json; charset=utf-8'
    // };
    // print("SUCCESSFULLY LOGGED IN Message 2");
    var body = json.encode(userData);
    // print("SUCCESSFULLY LOGGED IN Message ${userData}");
    final response = await http.post(Uri.parse("https://hsd-qatar.com/qactivity/login"), body: body);
    print("Login Response ${response.body}");
    var jsonData = json.decode(response.body) as Map;
    print("Login Response $jsonData");
    // if (jsonData['success'] != false) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    //   // print("SUCCESSFULLY LOGGED IN Message ${jsonData["Message"]}");
    //   // print("SUCCESSFULLY LOGGED IN Token ${jsonData["Response"]['Token']}");
    //
    //   // SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   //
    //   // localStorage.setString('token', jsonData["Response"]['Token']);
    //   // localStorage.setString('userID', json.encode(jsonData["Response"]['Id']));
    //   // localStorage.setString(
    //   //     'userFN', json.encode(jsonData["Response"]['FirstName']));
    //   // localStorage.setString(
    //   //     'userLN', json.encode(jsonData["Response"]['LastName']));
    //   // localStorage.setString(
    //   //     'userPhone', json.encode(jsonData["Response"]['Mobile']));
    //   // localStorage.setString(
    //   //     'userEmailId', json.encode(jsonData["Response"]['Email']));
    //
    //   // Navigator.pushAndRemoveUntil(
    //   //   context,
    //   //   new MaterialPageRoute(
    //   //     builder: (context) => MainScreen(0),
    //   //   ),
    //   //       (route) => false,
    //   // );
    //   // print("This is the User Token -  ${localStorage.getString('token')}");
    //
    //   // var url = APIConstants.API_BASE_URL_DEV + "api/user";
    //   // Map<String, String> requestHeaders = {
    //   //   'x-api-key': '987654',
    //   //   'Content-type': 'application/json',
    //   //   //'Accept': 'application/json',
    //   //   //'Authorization': 'Bearer ${jsonData['access_token']}'
    //   //   //'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZmMjc2ZGU3YTI1YWE3MDlmOTdiYjcwZDllODY3ZGNjNzllNWRjMzJmOGZlZjNlNWQ1YzhlMzM5YTU5ZjMyNTU2YWNlZWM1YTdlZDc3MjY0In0.eyJhdWQiOiIyIiwianRpIjoiNmYyNzZkZTdhMjVhYTcwOWY5N2JiNzBkOWU4NjdkY2M3OWU1ZGMzMmY4ZmVmM2U1ZDVjOGUzMzlhNTlmMzI1NTZhY2VlYzVhN2VkNzcyNjQiLCJpYXQiOjE1ODA1NDM5ODUsIm5iZiI6MTU4MDU0Mzk4NSwiZXhwIjoxNjEyMTY2Mzg1LCJzdWIiOiIxMzIiLCJzY29wZXMiOltdfQ.h33_EIU37oXVwrBR3bU6Y7NzyoM4m1wue-09NkDOh4AEimZ9mjjoqxU2fvGEZ_Bo-o6sE5hNg_84bJ-WctedsnoEdwNSPt1O_1SWIrIFhyU5vvv1i9HyBIKx_l4uZLcC-C52TxxvO2awQrrDHPxcbAsyqqa7Z3jh02dAN91r-6Oe0XaH6OV-FabwSMdsWh028GxuIzJwATfHA_zPfDtIquG1TBLc7Q9cFOzlio7IOy3tOLCxVL4f_vt-aOwVF0C0M_eTgk8znI7nTpWk3TgKN_OjRegxbkSGXrS59SIMNZUhMBI1j1vmzSFmRlpEZ8vj5csFxnmTv9oT5tLviD06y8TIISHifpUMI4z2o4rg_qFQbHTAkf37pw2TCfsbzL5sIWMFwWNvbpeKmplurcsnqbzcXl7STqrHftWEwxz6a4Cjrt2fCcxWAkS3CzraANhMkDFuS9oaRqLGfGsZytOZVLTYzQi3HanEip_NqhtEDLhkiEZ6LSJg9CSkk9q9gjruM3zs-l_GijkwJZpdgHwb06SXQb1hF8sS-pcXMwKHU-nF9zKoYZYjodSLaawFtNleylQqZO1mg9gK0XEoMHqm1NXdJH54mqSjoIKmDtKPbmGINzERRB6Cls0pHjC5Z82JBZ9g7xwmOJbMGdN7i2rZhOzs4Mq-eT85nsP2-SNPiJE'
    //   // };
    //   // final response = await http.get(url,headers: requestHeaders);
    //   // var res =json.decode(response.body);
    //   // localStorage.setString('name', res["name"]);
    //   // Navigator.of(context).pushAndRemoveUntil(
    //   //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
    //   //         (Route<dynamic> route) => false);
    // } else {
    //   setState(() {
    //     _isLoading = false;
    //     //print("UNSUCCESSFULLY LOGGED IN Message ${response.body}");
    //   });
    //   showLoginAlertDialog(context);
    // }
    //showLoginAlertDialog(context);
  }


  Future<void> showLoginAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Invalid Credentials!'),
          content: Text('Try Again With Valid Credentials!'),
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

  Widget _logButton(context) {
    return SizedBox(
      height: 50,
      width: 350,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.white)),
        ),
        onPressed: () {
          signIn();
          if (_key.currentState!.validate()) {

          } else {
            showLoginAlertDialog(context);
            setState(() {
              _validate = true;
            });
            //showLoginAlertDialog(context);
          }
        },
        //color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          // padding: EdgeInsets.fromLTRB(
          //     SizeConfig.safeBlockHorizontal * 5,
          //     0,
          //     SizeConfig.safeBlockHorizontal * 5,
          //     0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Login',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "cairo",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              // Icon(
              //   Icons.arrow_forward_ios,
              //   color: Colors.white,
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(

        ),
        onPressed: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          //   return ForgotPassword();
          // }));
        },
        //padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "cairo",
          ),
        ),
      ),
    );
  }

  Widget logoImage() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        image: DecorationImage(
          image: AssetImage(imgLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
      Navigator.pushNamed(context, signUpRoute)
      }, //print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Do not have an Account?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "cairo",
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: "cairo",
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF1BCFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1BCFFF),
      ),
      body: new Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop),
              image: AssetImage(imgSplash),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            //padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    logoImage(),

                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        //alignment: Alignment.topLeft,
                        child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "cairo",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.number,
                        //maxLength: 8,
                        style: TextStyle(
                          color: Colors.white, fontFamily: "cairo",
                          //   fontFamily: 'SFUIDisplay'
                        ),
                        validator: (String? value) {
                          String pattern =
                              r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(pattern);
                          if (value!.isEmpty) {
                            return "Mobile Number is Required";
                          }else if (value.length > 5) {
                            return "Mobile Number must minimum eight characters";
                          }
                          return null;
                        },
                        // keyboardType: TextInputType.visiblePassword,
                        //obscureText: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: "Mobile Number",
                            prefixIcon: Icon(Icons.person,color: Colors.white,),
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "cairo",
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 50.0,
                      child: TextFormField(
                        // autovalidate:true,
                        //key: _formKey,
                        //maxLength: 10,
                        controller: passwordController,
                        validator: (String? value) {
                          String pattern =
                              r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
                          RegExp regExp = new RegExp(pattern);
                          if (value!.isEmpty) {
                            return "Password is Required";
                          } else if (value.length < 8) {
                            return "Password must minimum eight characters";
                          }
//                } else if (!regExp.hasMatch(value)) {
//                  return "Password at least one uppercase letter, one lowercase letter and one number";
//                }
                          return null;
                        },
                        obscureText: showpassword,
                        style: TextStyle(
                          color: Colors.white, fontFamily: "cairo",
                          //fontFamily: 'OpenSans',
                        ),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => {showPassword()},
                              icon: Icon(
                                Icons.visibility,
                                color: showpassword
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock_open,color: Colors.white,),
                            labelStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: "cairo",
                                color: Colors.white)),
                      ),
                    ),

                    //registerButton(),
//                    SizedBox(
//                      height: 15.0,
//                    ),
//                    buildSignupBtn(),
                    SizedBox(height: 20.0),
                    //_loginButton(),
                    _logButton(context),
                    SizedBox(height: 10.0),
                    //_guestButton(),
                    buildForgotPasswordBtn(),
                    //SizedBox(height: 10.0),
                    Center(child: buildSignupBtn()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

