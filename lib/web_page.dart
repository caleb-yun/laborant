import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'news_page.dart';

class WebPage extends StatelessWidget {

  News news;

  WebPage({Key key, @required this.news}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: WebView(
        initialUrl: news.url,
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}