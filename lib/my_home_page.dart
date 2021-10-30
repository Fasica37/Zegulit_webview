import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController _controller;

  _goBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    }
  }

  _goForward() async {
    if (await _controller.canGoForward()) {
      await _controller.goForward();
    }
  }

  num position = 1;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Zegulit', style: TextStyle(color: Colors.black),),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: _goBack,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.black),
              onPressed: _goForward,
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: IndexedStack(index: position, children: <Widget>[
          WebView(
            initialUrl: 'https://www.zegulit.com/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
            navigationDelegate: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            userAgent:
                'Mozilla/5.0 (Linux; Android 4.1.1; Galaxy Nexus Build/JRO03C) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19',
            onPageStarted: (value) {
              setState(() {
                position = 1;
              });
            },
            onPageFinished: (value) {
              setState(() {
                position = 0;
              });
            },
          ),
          Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        ]));
  }
}