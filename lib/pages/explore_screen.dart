import 'package:flutter/material.dart';
import 'package:flutter_localization_master/router/route_constants.dart';

// ignore: must_be_immutable
class ExploreScreen extends StatelessWidget {
  bool isLangArabic = false;
  var arLang = "Ar";
  var enLang = "En";

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: new BoxDecoration(color: Color(0xFF3c0000)),
      decoration: BoxDecoration(
        //shape: BoxShape.circle,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop),
          image: AssetImage('images/splash1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 20.0,),
              logoImage(),
              SizedBox(height: 250.0,),
              _exploreButton(context),
              SizedBox(height: 20.0,),
              _signButton(context),
              SizedBox(height: 70.0,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exploreButton(context) {
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
        onPressed: () async {
          Navigator.pushNamed(context, homeRoute);
          // Navigator.of(context)
          //     .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          //   return LoginRegistrationScreen();
          // }));
        },
        //color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Explore",
                style: TextStyle(
                  fontSize: 15,
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

  Widget _signButton(context) {
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
        onPressed: () async {
          Navigator.pushNamed(context, userTypesScreen);
          //changeLanguage("ar", context);
          print("Arabic button is pressed");
          // Navigator.pushReplacement(
          //   context,
          //   new MaterialPageRoute(builder: (context) => LoginRegistrationScreen()),
          // );
          // Navigator.of(context)
          //     .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          //   return LoginRegistrationScreen();
          // }));
        },
        //color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Sign Up / Sign In',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
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

  Widget logoImage() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        image: DecorationImage(
          image: AssetImage(imgLogo),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}