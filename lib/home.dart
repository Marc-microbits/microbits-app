import 'package:http/http.dart' as http;
import 'Dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'hidden.dart';
import 'camera.dart';



class CustIcon {
  final String Id;
  final String name;

  CustIcon({this.Id, this.name});


  factory CustIcon.fromJson(List<dynamic> json) {
    return CustIcon(
      Id: json[0],
      name: json[1],
    );
  }

  String getName(){
    return this.name;
  }

}

Future<List<CustIcon>> fetchIcons() async {
  final response = await http.get('http://microbits.digital/flutter/microbits/home.php');
  List<CustIcon> custIcons = new List<CustIcon>();

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    var res = json.decode(response.body);
    for(var i=0;i<res.length;i++){
      custIcons.add(CustIcon.fromJson(res[i]));
    }
    return custIcons;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<List<CustIcon>> waitSomeSecs() async{
  return new Future.delayed(const Duration(seconds: 3), () => new List<CustIcon>());
}


buildHome(AppBar appBar,double _screenWidth, double _slider) {
  const IconData _fbIcon = const IconData(0xf09a, fontFamily: 'facebook');

  return FutureBuilder(
    future: Future.wait([
      fetchIcons(),
      waitSomeSecs()
    ]),

    builder: (BuildContext context, AsyncSnapshot<List<List<CustIcon>>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:{
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/loader.gif'),)
                    ),
                    margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                    height: 400,
                    width: 200,
                  ),
                  Container(
                    child: new CircularProgressIndicator(backgroundColor: Colors.white,),
                  )
                ],
              )
            ),
          ) ;

        }
        default:
          if (snapshot.hasError) {
            return new Text('Connection Error: ${snapshot.error}');
          }
          else {
            var IconsData = snapshot.data[0];
            return Scaffold(
                appBar: appBar,
                body: ListView(
                    children:[
                      Row(
                          children:[
                            Stack(
                                children:[
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white
                                      ),
                                      width: _screenWidth,
                                      height: _slider
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.elliptical(500,300)
                                        ),
                                        color: Colors.white,
                                      ),
                                      width: _screenWidth,
                                      height: _slider
                                  ),
                                  Container(
                                      foregroundDecoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/slice-white.png'),alignment: Alignment(1, 1),
                                        ),
                                      ),
                                      width: _screenWidth,
                                      height: _slider,
                                      child: new Carousel(
                                        images: [
                                          AssetImage('images/slide1.jpg'),
                                          AssetImage('images/slide1.jpg'),
                                          AssetImage('images/slide1.jpg')
                                        ],
                                        showIndicator: false,
                                        autoplay: true,
                                        autoplayDuration: Duration(seconds: 5),
                                      )
                                  ),

                                ]
                            )
                          ]
                      ),
                      Row(
                          children:[
                            Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      openCamera();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white
                                      ),
                                      width: MediaQuery.of(context).size.width * 1 / 3,
                                      height: MediaQuery.of(context).size.width * 1 / 3,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Icon(Icons.perm_identity,color: Color(0xFF105b8e),size: 40,),
                                            Text(IconsData[0].name, style: TextStyle(color: Color(0xFF105b8e),fontSize: 17),)
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                      ),

                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    ),
                                    width: MediaQuery.of(context).size.width * 1 / 3,
                                    height: MediaQuery.of(context).size.width * 1 / 3,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(Icons.work,color: Color(0xFF105b8e),size: 45,),
                                          Text(IconsData[1].name, style: TextStyle(color: Color(0xFF105b8e),fontSize: 17),)
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),
                                  )

                                ]
                            )
                            ,Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                  width: MediaQuery.of(context).size.width * 1 / 3,
                                  height: MediaQuery.of(context).size.width * 1 / 3,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(Icons.star_border,color: Color(0xFF105b8e),size: 47,),
                                        Text(IconsData[2].name, style: TextStyle(color: Color(0xFF105b8e),fontSize: 17),)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                  ),

                                ),Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                  width: MediaQuery.of(context).size.width * 1 / 3,
                                  height: MediaQuery.of(context).size.width * 1 / 3,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(Icons.local_phone,color: Color(0xFF105b8e),size: 45,),
                                        Text(IconsData[3].name, style: TextStyle(color: Color(0xFF105b8e),fontSize: 17),)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                  ),
                                )],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white
                                  ),
                                  width: MediaQuery.of(context).size.width * 1 / 3,
                                  height: MediaQuery.of(context).size.width * 1 / 3,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Icon(Icons.apps,color: Color(0xFF105b8e),size: 45,),
                                        Text(IconsData[4].getName(), style: TextStyle(color: Color(0xFF105b8e),fontSize: 17),)
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                  ),

                                ),GestureDetector(
                                  onLongPress: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => HiddenRoute())
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white
                                    ),
                                    width: MediaQuery.of(context).size.width * 1 / 3,
                                    height: MediaQuery.of(context).size.width * 1 / 3,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Icon(_fbIcon,color: Color(0xFF105b8e),size: 40,),
                                          Text(IconsData[5].name, style: TextStyle(color: Color(0xFF105b8e),fontSize: 17),)
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            )
                          ]
                      )
                    ]
                )
            );
          }

      }
    },
  );
}