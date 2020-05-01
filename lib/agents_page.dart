import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class AgentsPage extends StatefulWidget {

  @override
  createState() => new AgentsPageState();

}

class AgentsPageState extends State<AgentsPage> {

  List _agentList = [];

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('AGENTS'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
      ),
      body:  Swiper(
          itemBuilder: (BuildContext context, int index) {
            Map agent = _agentList[index];
            return Card(
              margin: EdgeInsets.only(top: 24, bottom: 36, left: 8, right: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(image:
                  DecorationImage(image: AssetImage(agent['img']), fit: BoxFit.fitHeight)
                ),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(agent['name'], style: TextStyle(color: Colors.white, fontSize: 36)),
                  Text(agent['type'], style: TextStyle(color: Colors.white70, fontSize: 24)),
                ])
              ),
              color: Color(0xFF0F1923),
            );
          },
          itemCount: _agentList.length,
          viewportFraction: 0.7,
          scale: 0.9,
        )
    );
  }

  Future<void> _fetchData() async {
    String body = await rootBundle.loadString('assets/agents.json');

    _agentList = json.decode(body);

    setState(() {});

  }

}