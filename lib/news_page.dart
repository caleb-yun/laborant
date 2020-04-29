import 'dart:core';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;


class News {
  String title;
  String description;
  String date;
  String url;
  String imgUrl;
}


class NewsPage extends StatefulWidget {
  @override
  createState() => new NewsPageState();
}


class NewsPageState extends State<NewsPage> {

  List<News> _newsList = [];
  bool _isLoading = true;
  BuildContext _scaffoldContext;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    _refreshList();

    super.initState();
  }

  Future<void> _refreshList() async {
    _newsList = [];
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHome();
  }

  Widget _buildHome() {
    return Scaffold(
      appBar: AppBar(
        title: Text('LABORANT'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: new Builder(builder: (BuildContext context) {
        _scaffoldContext = context;
        return _isLoading ?
            new Center(child: CircularProgressIndicator())
            : _buildList();
      })
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshList,
      child: _newsList.length > 0 ? ListView.builder(
          itemCount: _newsList.length,
          itemBuilder: (context, index) {
            if (index == 0)
              return _buildFeaturedItem(_newsList[index]);
            return _buildItem(_newsList[index]);
          })
          : Center(child: Icon(Icons.error_outline, size: 48)),
    );
  }

  Widget _buildItem(News news) {
    return ListTile(
      leading: Card(
        margin: EdgeInsets.all(0),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
          child: Image.network(news.imgUrl)
      ),
      title: Text(news.title),
      subtitle: Text(news.date),
    );
  }

  Widget _buildFeaturedItem(News news) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 10,
      margin: EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 220,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(news.imgUrl), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
            children: [
              Text(news.title, style: TextStyle(fontSize: 18, color: Colors.white)),
              Text(news.date, style: TextStyle(color: Colors.white70))
            ]
        )
      )

    );
  }

  Future _fetchData() async {
    try {
      String url = 'https://beta.playvalorant.com/en-us/news/';
      var client = Client();
      Response response =
      await client.get(url);

      var document = parse(response.body);
      List<dom.Element> newsItems = document.querySelectorAll(
          'div.NewsArchive-module--content--_kqJU > div.NewsArchive-module--newsCardWrapper--2OQiG');

      for (var item in newsItems) {
        News news = new News()
          ..title = item.querySelector('h5').text
          ..url = url + item.querySelector('a').attributes['href']
          ..date = item.querySelector('p.NewsCard-module--published--37jmR').text
          ..description = item.querySelector('p.NewsCard-module--description--3sFiD').text
          ..imgUrl = item.querySelector('.NewsCard-module--image--2sGrc').attributes['style'].replaceAll(RegExp(r'background-image: url\(|background-image:url\(|\)'), '');

        _newsList.add(news);
      }

    } catch (e) {
      debugPrint(e.toString());
      Scaffold.of(_scaffoldContext)
          .showSnackBar(SnackBar(content: Text('Error fetching news')));
    }

    setState(() {
      _isLoading = false;
    });
  }


}