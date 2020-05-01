import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  @override
  createState() => new StatsPageState();
}

class StatsPageState extends State<StatsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STATS'),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.build)
            ),
            Text('COMING SOON'),
          ])
      )
    );
  }
}
