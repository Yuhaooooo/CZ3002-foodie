import 'dart:async';
import 'package:foodie/getfood/SelectDish1.dart';
import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:foodie/home.dart';
import 'dart:io';


const kAndroidUserAgent = "Mozilla/5.0 (Linux; Android 4.4.4; One Build/KTU84L.H4) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Mobile Safari/537.36 [FB_IAB/FB4A;FBAV/28.0.0.20.16;]";
String selectedUrl = 'http://baseride.com/maps/public/ntu/';

//HttpClient _client = new HttpClient();
//_client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

class BusPage extends StatefulWidget {
  const BusPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BusPageState createState() => new _BusPageState();
}

class _BusPageState extends State<BusPage> {
  // Instance of WebView plugin
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  // On destroy stream
  StreamSubscription _onDestroy;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  // On urlChanged stream
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  StreamSubscription<WebViewHttpError> _onHttpError;

  StreamSubscription<double> _onScrollYChanged;

  StreamSubscription<double> _onScrollXChanged;

  final _urlCtrl = new TextEditingController(text: selectedUrl);

  final _codeCtrl =
  new TextEditingController(text: 'window.navigator.userAgent');

  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _history = [];


  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.launch(selectedUrl,userAgent: kAndroidUserAgent);
    final Rect rect = new Rect.fromLTWH(0.0, 35.0, 370, 600);
    flutterWebviewPlugin.resize(rect);
    _urlCtrl.addListener(() {
      selectedUrl = _urlCtrl.text;
    });
    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      if (mounted) {
        // Actions like show a info toast.
        _scaffoldKey.currentState.showSnackBar(
            const SnackBar(content: const Text('Bus Page Closed')));
      }
    });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          _history.add('onUrlChanged: $url');
        });
      }
    });

    _onScrollYChanged =
        flutterWebviewPlugin.onScrollYChanged.listen((double y) {
          if (mounted) {
            setState(() {
              _history.add("Scroll in  Y Direction: $y");
            });
          }
        });

    _onScrollXChanged =
        flutterWebviewPlugin.onScrollXChanged.listen((double x) {
          if (mounted) {
            setState(() {
              _history.add("Scroll in  X Direction: $x");
            });
          }
        });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          if (mounted) {
            setState(() {
              _history.add('onStateChanged: ${state.type} ${state.url}');
            });
          }
        });

    _onHttpError =
        flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
          if (mounted) {
            setState(() {
              _history.add('onHttpError: ${error.code} ${error.url}');
            });
          }
        });
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _onScrollXChanged.cancel();
    _onScrollYChanged.cancel();

    flutterWebviewPlugin.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Campus Bus'),
      ),
      body:
      new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            padding: const EdgeInsets.all(24.0),
            child: new TextField(controller: _urlCtrl),

          ),
          Align(
              child: Wrap(
                  children:[

                  ]
              )
          ),

          new Container(
            margin: const EdgeInsets.only(top: 400.0),
            child : new RaisedButton(
              onPressed:(){
                setState(() {
                  _history.clear();
                });
                flutterWebviewPlugin.close();
                Navigator.push(context,
                  MaterialPageRoute(builder:
                      (context) => Home()),
                )
                ;},
              child: const Text('Back to home'),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}