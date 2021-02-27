import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'home.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'microbits',
      theme: ThemeData(

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see theonline
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: createMaterialColor(Color(0xFF105b8e))
      ),
      home: MyHomePage(title: 'microbits'),
    );
  }

}


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}



class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    var after = new AfterSplash();
//    return new SplashScreen(
//        seconds: 3,
//        navigateAfterSeconds: after,
//
//        image: new Image(image: new AssetImage("images/loader.gif")),
//        backgroundColor: Colors.white,
//        photoSize: 100.0,
//        loaderColor: Color(0xFF105b8e),
//    );
  return after;
  }
}



class AfterSplash extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var _tile = MediaQuery.of(context).size.width / 3;
    var Homepage = new Scaffold();
    AppBar appBar = AppBar(
        title: Text("microbits"),
    centerTitle: true,
    );
    var _slider = MediaQuery.of(context).size.height - appBar.preferredSize.height - 2*_tile - 30;

      return buildHome(appBar, _screenWidth, _slider);
  }
}



class WardiehRoute extends StatelessWidget{

  final _key = UniqueKey();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Wardieh")
      ),
      body:
            Column(
              children: [
                Expanded(
                  child: WebView(
                    key: _key,
                    initialUrl: Uri.dataFromString('<html><body><iframe src="http://wardiehapp.microbitstest.com/admin" style="width:100%;height:100%;border:0;"></iframe></body></html>', mimeType: 'text/html').toString(),
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                )
              ],
            )
    );
  }
}

