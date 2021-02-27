import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Dart:convert';

class DisplayImages extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  Future<List> fetchImages() async {
    final response = await http.get('http://microbits.digital/flutter/microbits/getImages.php');
    List images = new List();

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var res = json.decode(response.body);
      for(var i=0;i<res.length;i++){
        images.add(res[i][1]);
      }
      return images;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        fetchImages()
      ]),

      builder: (BuildContext context, AsyncSnapshot<List<List>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:{
            return Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                  child: Column(
                    children: <Widget>[
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
              return new Text('Error: ${snapshot.error}');
            }
            else {
              var Images = snapshot.data[0];
              var url = 'http://microbits.digital/flutter/microbits/uploads/';
              var final_images = new List();
              for(var i=0;i<Images.length;i++){
                final_images.add(url+Images[i]);
              }
              print(final_images);
              return Scaffold(
                  appBar: AppBar(
                      title: Text("Images from DB")
                  ),
                  body:
                        new ListView.builder
                          (
                            itemCount: final_images.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                            return Container(
                              child: Image.network(final_images[index],width: 200,fit: BoxFit.fitWidth,),
                              width: 200,
                            );

                            }
                        )
              );
            }

        }
      },
    );
  }

}