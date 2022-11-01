import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_master/classes/constant.dart';
import 'package:flutter_localization_master/pages/activity_details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivityList extends StatefulWidget {
  const ActivityList({Key? key, this.id, this.name, this.image, this.price, this.address}) : super(key: key);
  final id;
  final name;
  final image;
  final price;
  final address;

  @override
  _ActivityListState createState() => _ActivityListState(this.id,this.name,this.image,this.price, this.address);
}

class _ActivityListState extends State<ActivityList> {
  final id;
  final name;
  final image;
  final price;
  final address;
  bool _isLoading = false;
  List activityList = [];
  String? phoneNumber = "+97450066668";
  String? description = "New activities near your favorite locations just go and explore it for best price.You can book your favorite activities and activity location and you can directly book via above contacts details, just call us or send text on above whatsapp number.  Gear up for one of the best day of your Vacation! our of professional tandem instructors are ready to take you on a";

  @override
  void initState() {
    // TODO: implement initState
    getCategory(widget.name);
    super.initState();
  }

  getCategory(catName)async{
      setState(() {
        _isLoading = true;
      });
      var getUrl = APIConstants.API_BASE_URL_DEV + APIOperations.getAllActivities;
      //var urlFinal = Uri.parse("https://hsd-qatar.com/qactivity/getAllActivities");
      final response = await http.get(Uri.parse("https://hsd-qatar.com/qactivity/getAllActivities"));
      print("All Vendors by Department data ===========->>> ${response.body}");
      final responseData = json.decode(response.body);
      final deptData = responseData['content'];
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

  _ActivityListState(this.id, this.name, this.image, this.price, this.address);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.name),
          elevation: 0,
          backgroundColor: Color(0xFF1BCFFF),
        ),
        body: _isLoading ? Center(child: CircularProgressIndicator()):activityList.length != 0?
        ListView.builder(
            itemCount: activityList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .30,
                child:InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ActivityDetailScreen(
                              id:activityList[index]['_id'],
                              name: activityList[index]['activity_name'],
                              image: activityList[index]['img'],
                              price: activityList[index]['price'],
                              phone: phoneNumber,
                              ratings: activityList[index]['Rating'],
                              address: activityList[index]['Location'],
                              description: description,
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
                            image:NetworkImage(activityList[index]['img']),
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
                              Text("${activityList[index]['activity_name']} \n${activityList[index]['Location']}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("${activityList[index]['price']}\nRating-${activityList[index]['Rating']}",
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
                ), );
            }): Center(
          child: Text("No Activities Found",
          textAlign: TextAlign.center,
          style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold),
        ),
            ),
    );
  }
}


