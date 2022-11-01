import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/router/route_constants.dart';


class SignUpScreen extends StatefulWidget {
@override
_SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _validate = false;
  bool _isLoading = false;
  var pinCode;
  var mobileNumber;
  bool showpassword = true;

  @override
  void initState() {
    // TODO: implement initState
   emailController.text = "email@gmail.com";
   mobileController.text = "66666666";
   passwordController.text = "123456789";
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    mobileController.dispose();
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

  Widget buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, loginRoute)
      }, //print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "cairo",
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
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

  // _sendMobileNumber() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final String apiURL =
  //   (APIConstants.API_BASE_URL_DEV + "sendCustomerMobileNumber");
  //   Map<String, dynamic> userData = {
  //     'Mobile': mobileController.text,
  //   };
  //   Map<String, String> requestHeaders = {
  //     'x-api-key': '987654',
  //     //'Content-type': 'application/json',
  //     //'Accept': 'application/json',
  //   };
  //   final response =
  //   await http.post(apiURL, body: userData, headers: requestHeaders);
  //   var jsonData = json.decode(response.body);
  //   print("Login Response $jsonData");
  //
  //   if (jsonData['Status'] == true) {
  //     pinCode = jsonData["Data"]['Pin'];
  //     mobileNumber = jsonData["Data"]['Mobile'];
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print("SUCCESSFULLY LOGGED IN Message ${jsonData["Message"]}");
  //     print(
  //         "Registered Mobile Number is =====>>>>  ${jsonData["Data"]['Mobile']}");
  //     print("Pin sent to Register number is ========>>>> ${pinCode}");
  //
  //     // SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     //
  //     // localStorage.setString('token', jsonData["Response"]['Token']);
  //     // localStorage.setString('userID', json.encode(jsonData["Response"]['Id']));
  //     // localStorage.setString('userFN', json.encode(jsonData["Response"]['FirstName']));
  //     // localStorage.setString('userLN', json.encode(jsonData["Response"]['LastName']));
  //     // localStorage.setString('userPhone', json.encode(jsonData["Response"]['Mobile']));
  //     // localStorage.setString('userEmailId', json.encode(jsonData["Response"]['Email']));
  //
  //     Navigator.pushReplacement(
  //       context,
  //       new MaterialPageRoute(
  //           builder: (context) => Otp(pinCode: pinCode, mobile: mobileNumber)),
  //     );
  //     // print("This is the User Token -  ${localStorage.getString('token')}");
  //
  //     // var url = APIConstants.API_BASE_URL_DEV + "api/user";
  //     // Map<String, String> requestHeaders = {
  //     //   'x-api-key': '987654',
  //     //   'Content-type': 'application/json',
  //     //   //'Accept': 'application/json',
  //     //   //'Authorization': 'Bearer ${jsonData['access_token']}'
  //     //   //'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZmMjc2ZGU3YTI1YWE3MDlmOTdiYjcwZDllODY3ZGNjNzllNWRjMzJmOGZlZjNlNWQ1YzhlMzM5YTU5ZjMyNTU2YWNlZWM1YTdlZDc3MjY0In0.eyJhdWQiOiIyIiwianRpIjoiNmYyNzZkZTdhMjVhYTcwOWY5N2JiNzBkOWU4NjdkY2M3OWU1ZGMzMmY4ZmVmM2U1ZDVjOGUzMzlhNTlmMzI1NTZhY2VlYzVhN2VkNzcyNjQiLCJpYXQiOjE1ODA1NDM5ODUsIm5iZiI6MTU4MDU0Mzk4NSwiZXhwIjoxNjEyMTY2Mzg1LCJzdWIiOiIxMzIiLCJzY29wZXMiOltdfQ.h33_EIU37oXVwrBR3bU6Y7NzyoM4m1wue-09NkDOh4AEimZ9mjjoqxU2fvGEZ_Bo-o6sE5hNg_84bJ-WctedsnoEdwNSPt1O_1SWIrIFhyU5vvv1i9HyBIKx_l4uZLcC-C52TxxvO2awQrrDHPxcbAsyqqa7Z3jh02dAN91r-6Oe0XaH6OV-FabwSMdsWh028GxuIzJwATfHA_zPfDtIquG1TBLc7Q9cFOzlio7IOy3tOLCxVL4f_vt-aOwVF0C0M_eTgk8znI7nTpWk3TgKN_OjRegxbkSGXrS59SIMNZUhMBI1j1vmzSFmRlpEZ8vj5csFxnmTv9oT5tLviD06y8TIISHifpUMI4z2o4rg_qFQbHTAkf37pw2TCfsbzL5sIWMFwWNvbpeKmplurcsnqbzcXl7STqrHftWEwxz6a4Cjrt2fCcxWAkS3CzraANhMkDFuS9oaRqLGfGsZytOZVLTYzQi3HanEip_NqhtEDLhkiEZ6LSJg9CSkk9q9gjruM3zs-l_GijkwJZpdgHwb06SXQb1hF8sS-pcXMwKHU-nF9zKoYZYjodSLaawFtNleylQqZO1mg9gK0XEoMHqm1NXdJH54mqSjoIKmDtKPbmGINzERRB6Cls0pHjC5Z82JBZ9g7xwmOJbMGdN7i2rZhOzs4Mq-eT85nsP2-SNPiJE'
  //     // };
  //     // final response = await http.get(url,headers: requestHeaders);
  //     // var res =json.decode(response.body);
  //     // localStorage.setString('name', res["name"]);
  //     // Navigator.of(context).pushAndRemoveUntil(
  //     //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
  //     //         (Route<dynamic> route) => false);
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //       //print("UNSUCCESSFULLY LOGGED IN Message ${response.body}");
  //     });
  //     showLoginAlertDialog(context);
  //   }
  //   //showLoginAlertDialog(context);
  // }

//   Future<void> showLoginAlertDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return CupertinoAlertDialog(
//           title: Text(
//             getTranslated(context, 'Mobile Exist!'),
//           ),
//           content: Text(
//             getTranslated(context, 'Mobile Number Already Exist'),
//           ),
//           actions: <Widget>[
//             CupertinoDialogAction(
//               child: Text(
//                 getTranslated(context, 'Ok'),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
// //                Navigator.pushReplacement(
// //                  context,
// //                  new MaterialPageRoute(builder: (context) => MainScreen()),
// //                );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

  signUp(String email, phone, password) async {
    setState(() {
      _isLoading = false;
    });
    // Map<String, String> requestHeaders = {
    //   'x-api-key': '987654',
    //   //'Content-type': 'application/json',
    //   //'Accept': 'application/json',
    // };
    try {
      final String apiURL = "https://hsd-qatar.com/qactivity/register";
      var urlFinal = Uri.parse("https://hsd-qatar.com/qactivity/register");
      Map<String, dynamic> userData = {
        "email": "ab@gmail.com",
        "password": "123456789",
        "phone": "5555",
      };
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var body = json.encode(userData);
      final response = await http.post(urlFinal, body: body);
      var jsonData = json.decode(response.body);
      print("Registration Response ${jsonData}");
      if (jsonData['success'] == true) {
        setState(() {
          _isLoading = false;
        });
        print("SUCCESSFULLY LOGGED IN Message ${jsonData["Message"]}");
        print("SUCCESSFULLY LOGGED IN Token ${jsonData["Response"]['Token']}");

        // SharedPreferences localStorage = await SharedPreferences.getInstance();
        //
        // localStorage.setString('token', jsonData["Response"]['Token']);
        // localStorage.setString('userID', json.encode(jsonData["Response"]['Id']));
        // localStorage.setString(
        //     'userFN', json.encode(jsonData["Response"]['FirstName']));
        // localStorage.setString(
        //     'userLN', json.encode(jsonData["Response"]['LastName']));
        // localStorage.setString(
        //     'userPhone', json.encode(jsonData["Response"]['Mobile']));
        // localStorage.setString(
        //     'userEmailId', json.encode(jsonData["Response"]['Email']));

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   new MaterialPageRoute(
        //     builder: (context) => MainScreen(0),
        //   ),
        //       (route) => false,
        // );
        // print("This is the User Token -  ${localStorage.getString('token')}");

        // var url = APIConstants.API_BASE_URL_DEV + "api/user";
        // Map<String, String> requestHeaders = {
        //   'x-api-key': '987654',
        //   'Content-type': 'application/json',
        //   //'Accept': 'application/json',
        //   //'Authorization': 'Bearer ${jsonData['access_token']}'
        //   //'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZmMjc2ZGU3YTI1YWE3MDlmOTdiYjcwZDllODY3ZGNjNzllNWRjMzJmOGZlZjNlNWQ1YzhlMzM5YTU5ZjMyNTU2YWNlZWM1YTdlZDc3MjY0In0.eyJhdWQiOiIyIiwianRpIjoiNmYyNzZkZTdhMjVhYTcwOWY5N2JiNzBkOWU4NjdkY2M3OWU1ZGMzMmY4ZmVmM2U1ZDVjOGUzMzlhNTlmMzI1NTZhY2VlYzVhN2VkNzcyNjQiLCJpYXQiOjE1ODA1NDM5ODUsIm5iZiI6MTU4MDU0Mzk4NSwiZXhwIjoxNjEyMTY2Mzg1LCJzdWIiOiIxMzIiLCJzY29wZXMiOltdfQ.h33_EIU37oXVwrBR3bU6Y7NzyoM4m1wue-09NkDOh4AEimZ9mjjoqxU2fvGEZ_Bo-o6sE5hNg_84bJ-WctedsnoEdwNSPt1O_1SWIrIFhyU5vvv1i9HyBIKx_l4uZLcC-C52TxxvO2awQrrDHPxcbAsyqqa7Z3jh02dAN91r-6Oe0XaH6OV-FabwSMdsWh028GxuIzJwATfHA_zPfDtIquG1TBLc7Q9cFOzlio7IOy3tOLCxVL4f_vt-aOwVF0C0M_eTgk8znI7nTpWk3TgKN_OjRegxbkSGXrS59SIMNZUhMBI1j1vmzSFmRlpEZ8vj5csFxnmTv9oT5tLviD06y8TIISHifpUMI4z2o4rg_qFQbHTAkf37pw2TCfsbzL5sIWMFwWNvbpeKmplurcsnqbzcXl7STqrHftWEwxz6a4Cjrt2fCcxWAkS3CzraANhMkDFuS9oaRqLGfGsZytOZVLTYzQi3HanEip_NqhtEDLhkiEZ6LSJg9CSkk9q9gjruM3zs-l_GijkwJZpdgHwb06SXQb1hF8sS-pcXMwKHU-nF9zKoYZYjodSLaawFtNleylQqZO1mg9gK0XEoMHqm1NXdJH54mqSjoIKmDtKPbmGINzERRB6Cls0pHjC5Z82JBZ9g7xwmOJbMGdN7i2rZhOzs4Mq-eT85nsP2-SNPiJE'
        // };
        // final response = await http.get(url,headers: requestHeaders);
        // var res =json.decode(response.body);
        // localStorage.setString('name', res["name"]);
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        //         (Route<dynamic> route) => false);
      }
      else {
        setState(() {
          _isLoading = false;
          //print("UNSUCCESSFULLY LOGGED IN Message ${response.body}");
        });
        showLoginAlertDialog(context);
      }
    } on Exception catch (exception) {
      print("throwing new error $exception");
    // only executed if error is of type Exception
    } catch (error) {
      print("something went wrong");
    // executed for errors of all types other than Exception
      showLoginAlertDialog(context);
    }
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF1BCFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1BCFFF),
      ),
      // decoration: BoxDecoration(
      //   //shape: BoxShape.circle,
      //   image: DecorationImage(
      //     image: AssetImage('images/bg.jpeg'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      body: Stack(fit: StackFit.expand,
          children: <Widget>[
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
                child: _isLoading? Center(child: CircularProgressIndicator()):SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        logoImage(),
                        SizedBox(
                          height: 80.0,
                        ),
                        Container(
                          height: 70,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
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
                                return "Email is Required";
                              }else if (!value.contains("@")){
                                return "Please Enter Valid Email Address";
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
                                labelText: "Email Address",
                                prefixIcon: Icon(Icons.email,color: Colors.white,),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "cairo",
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 70,
                          child: TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            maxLength: 8,
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
                              }else if (value.length < 8) {
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
                                prefixIcon: Icon(Icons.phone,color: Colors.white,),
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: "cairo",
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
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
                        SizedBox(
                          height: 20.0,
                        ),
                        _registerButton(context),
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(child: buildSignupBtn()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ]
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



  Widget _registerButton(context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.white)),
        ),
        onPressed: () {
          // if (_key.currentState!.validate()) {
          //   //_sendMobileNumber();
          //   //_isLoading = true;
          //
          // } else {
          //   //showLoginAlertDialog(context);
          //   setState(() {
          //     _validate = true;
          //   });
          //   //showLoginAlertDialog(context);
          // }
          if (_key.currentState!.validate()) {
            signUp(emailController.text ,mobileController.text, passwordController.text);
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
              Text(
                'Register',
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

}