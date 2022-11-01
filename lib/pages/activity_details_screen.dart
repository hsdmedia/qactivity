import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/classes/constant.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class ActivityDetailScreen extends StatefulWidget {
  const ActivityDetailScreen({Key? key, this.id, this.name, this.image, this.price,this.phone,this.ratings, this.address,this.description}) : super(key: key);
  final id;
  final name;
  final image;
  final price;
  final phone;
  final ratings;
  final address;
  final description;

  @override
  _ActivityDetailScreenState createState() => _ActivityDetailScreenState(this.id, this.name, this.image, this.price,this.phone,this.ratings, this.address,this.description);
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  final id;
  final name;
  final image;
  final price;
  final phone;
  final ratings;
  final address;
  final description;
  bool _isLoading = false;
  bool _isFav = false;
  List activityList = [];
  bool _hasCallSupport = false;
  Future<void>? _launched;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory(widget.name);
    print("All Vendors by Department data ===========->>> ${widget.name}");

  }
  _callNumber() async{
    var number = widget.phone; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
  _launchWhatsapp() async {
    var whatsapp = widget.phone;
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  getCategory(catName)async{
    setState(() {
      _isLoading = true;
    });
    var getUrl = APIConstants.API_BASE_URL_DEV + APIOperations.getAllActivities;
    var urlFinal = Uri.parse(getUrl);
    final response = await http.get(urlFinal);
    final responseData = json.decode(response.body);
    final deptData = responseData['content'];
    // print("All Vendors by Department data ===========->>> ${deptData.length}");
    List dataCat = [];
    List addCatData = [];
    //var dataLength = deptData.length;
    for (int i = 0; i < deptData.length; i++) {
      dataCat.add(deptData[i]);
      if(dataCat[i]['category'].toString().toLowerCase() == catName.toString().toLowerCase()){
        addCatData.add(dataCat[i]);
        // print("All Vendors by Department data ===========->>> ${dataCat[i]['category']}");
      }

    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      activityList = addCatData;
      // print("All Vendors by Department data ===========->>> ${activityList.length}");
    });

  }

  _sendingMails() async {
    var url = Uri.parse("mailto:info@hsd-qatar.com");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  addToFav(String id) async {
    setState(() {
      _isLoading = true;
    });
    var urlFinal = Uri.parse("https://hsd-qatar.com/qactivity/favorites");
    Map<String, dynamic> userData = {
      "userId": "635fcd79c2d7f1e999fc38cc",
      "activity": "$id",
    };
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(urlFinal, body: userData);
    var jsonData = json.decode(response.body);
    print("favorite Response $jsonData");
    if (jsonData['success'] != false) {
      setState(() {
        _isLoading = false;
      });
      addToFavAlert(context);
      // print("SUCCESSFULLY LOGGED IN Message ${jsonData["Message"]}");
      // print("SUCCESSFULLY LOGGED IN Token ${jsonData["Response"]['Token']}");

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
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      //showLoginAlertDialog(context);
    }
    //showLoginAlertDialog(context);
  }

  deleteToFav(String id) async {
    setState(() {
      _isLoading = true;
    });
    var urlFinal = Uri.parse("https://hsd-qatar.com/qactivity/favorites/delete");
    Map<String, dynamic> userData = {
      "userId": "635fcd79c2d7f1e999fc38cc",
      "activity": "$id",
    };
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(urlFinal, body: userData);
    var jsonData = json.decode(response.body);
    print("favorite Response $jsonData");
    if (jsonData['success'] != false) {
      setState(() {
        _isLoading = false;
      });
      deleteToFavAlert(context);
      // print("SUCCESSFULLY LOGGED IN Message ${jsonData["Message"]}");
      // print("SUCCESSFULLY LOGGED IN Token ${jsonData["Response"]['Token']}");

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
    } else {
      // setState(() {
      //   _isLoading = false;
      // });
      //showLoginAlertDialog(context);
    }
    //showLoginAlertDialog(context);
  }

  Future<void> addToFavAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Favorites!'),
          content: Text('This Activity has been added to your favorite List'),
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

  Future<void> deleteToFavAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Favorites Alert!'),
          content: Text('This Activity has been Removed from your favorite List'),
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

  _ActivityDetailScreenState(this.id, this.name, this.image, this.price,this.phone,this.ratings, this.address,this.description);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        elevation: 0,
        backgroundColor: Color(0xFF1BCFFF),
      ),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: 10, left: 12, right: 12, bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                      image:NetworkImage(widget.image),
                      // image: CachedNetworkImage(
                      //   imageUrl: activityList[index]['img'],
                      //   placeholder: (context, url) => new CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) => new Icon(Icons.error),
                      // ),
                      // activityList[index]['img'] == null
                      //     ? AssetImage('images/placeholder.png'):FileImage(activityList[index]['img']),
                      // data[index]['image'].toString().isEmpty
                      //     ? AssetImage(data[index]['image'])
                      //     : Image.asset(data[index]['image']),
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.name} \n${widget.address}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("${widget.price}\nRating-${widget.ratings}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Book Via",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: _isFav ?Icon(Icons.favorite_outlined,color: Colors.red,):Icon(Icons.favorite_border_outlined),
                  onPressed: () {
                    setState(() {
                      if(_isFav){
                        _isFav = false;
                        deleteToFav(widget.id);
                      }else{
                        _isFav = true;
                        print('tapped on activity id ==>> ${widget.id}');
                        addToFav(widget.id);
                       // print('tapped on activity id ==>> ${activityList[index]['_id']}');
                      }
                    });
                    //_getList();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            TextButton.icon(style: TextButton.styleFrom(
              primary: Colors.black,
              backgroundColor: Colors.transparent,
              //elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.grey)),
              ),
                onPressed: (){
                  _callNumber();
                  },
                icon: Icon(Icons.call), label: Text('Call')),
              TextButton.icon(style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.transparent,
                //elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.grey)),
              ),
                  onPressed: (){
                    //_launchWhatsapp();
                    var url = Uri.parse("https://wa.me/${widget.phone}?text=Hello");
                    launchUrl(url);
                  },
                  icon: Icon(Icons.whatsapp), label: Text('WhatsApp')),
              TextButton.icon(style: TextButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Colors.transparent,
                //elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.grey)),
              ),
                  onPressed: (){
                    _sendingMails();
                  },
                  icon: Icon(Icons.mail), label: Text('Mail')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${widget.description} ${widget.name}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontFamily: "cairo",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
      // _isLoading ? Center(child: CircularProgressIndicator()):activityList.length != 0?
      // ListView.builder(
      //     itemCount: activityList.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Container(
      //         width: MediaQuery.of(context).size.width,
      //         height: MediaQuery.of(context).size.height * .30,
      //         child:InkWell(
      //           onTap: () {
      //             // Navigator.push(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //       builder: (context) => ProductDetailScreen(
      //             //         id: filterName[index]['Id'],
      //             //         title: filterName[index]['NameEn'],
      //             //         titleAr: filterName[index]['NameAr'],
      //             //         price: filterName[index]['Price'],
      //             //         shortDes: filterName[index]['ShortDescriptionEn'],
      //             //         shortDesAr: filterName[index]['ShortDescriptionAr'],
      //             //         description: filterName[index]['DescriptionEn'],
      //             //         descriptionAr: filterName[index]['DescriptionAr'],
      //             //         userId: filterName[index]['UserId'],
      //             //         vendorId: filterName[index]['VendorId'],
      //             //         inStock: filterName[index]['StockStatus'],
      //             //       ),
      //             //     ));
      //             // Navigator.push(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //         builder: (context) => ActivityList(
      //             //           id:data[index]['id'],
      //             //           name: data[index]['name'],
      //             //           image: data[index]['image'],
      //             //         )));
      //           },
      //           child: Container(
      //               margin: EdgeInsets.only(
      //                   top: 10, left: 12, right: 12, bottom: 10),
      //               width: MediaQuery.of(context).size.width,
      //               height: MediaQuery.of(context).size.height * .15,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: Colors.white,
      //                   image: DecorationImage(
      //                       image:NetworkImage(activityList[index]['img']),
      //                       // image: CachedNetworkImage(
      //                       //   imageUrl: activityList[index]['img'],
      //                       //   placeholder: (context, url) => new CircularProgressIndicator(),
      //                       //   errorWidget: (context, url, error) => new Icon(Icons.error),
      //                       // ),
      //                       // activityList[index]['img'] == null
      //                       //     ? AssetImage('images/placeholder.png'):FileImage(activityList[index]['img']),
      //                       // data[index]['image'].toString().isEmpty
      //                       //     ? AssetImage(data[index]['image'])
      //                       //     : Image.asset(data[index]['image']),
      //                       colorFilter: new ColorFilter.mode(
      //                           Colors.black.withOpacity(0.4),
      //                           BlendMode.darken),
      //                       fit: BoxFit.fill),
      //                   boxShadow: [
      //                     BoxShadow(
      //                         color: greyColor,
      //                         blurRadius: 3,
      //                         spreadRadius: 1)
      //                   ]),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(12.0),
      //                 child: Container(
      //                   alignment: Alignment.bottomCenter,
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text("${activityList[index]['activity_name']} \n${activityList[index]['Location']}",
      //                         textAlign: TextAlign.start,
      //                         style: TextStyle(
      //                             color: Colors.white,
      //                             fontSize: 14,
      //                             fontWeight: FontWeight.bold),
      //                       ),
      //                       Text("${activityList[index]['price']}\nRating-${activityList[index]['Rating']}",
      //                         textAlign: TextAlign.center,
      //                         style: TextStyle(
      //                             color: Colors.white,
      //                             fontSize: 12,
      //                             fontWeight: FontWeight.bold),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               )),
      //         ), );
      //     }): Center(
      //   child: Text("No Activities Found",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         color: Colors.blueAccent,
      //         fontSize: 12,
      //         fontWeight: FontWeight.bold),
      //   ),
      // ),
    );
  }
}


