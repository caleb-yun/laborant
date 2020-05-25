import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeaponsPage extends StatefulWidget {

  @override
  createState() => new WeaponsPageState();

}

class WeaponsPageState extends State<WeaponsPage> {

  Map _weaponList = {};

  @override
  void initState() {
    _populateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Text('WEAPONS'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            bottom: TabBar(
                isScrollable: true,
                tabs: <Widget>[
              Tab(text: 'SIDEARM'),
              Tab(text: 'SMG'),
              Tab(text: 'SHOTGUN'),
              Tab(text: 'RIFLE'),
              Tab(text: 'SNIPER'),
              Tab(text: 'HEAVY')
            ]),
          ),
        body: TabBarView(
          children: <Widget>[
            _buildList(_weaponList['sidearm']),
            _buildList(_weaponList['smg']),
            _buildList(_weaponList['shotgun']),
            _buildList(_weaponList['rifle']),
            _buildList(_weaponList['sniper']),
            _buildList(_weaponList['heavy'])
          ],
        ),
      )
    );
  }

  Widget _buildList(List itemList) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: itemList==null ? 0 : itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color(0xFF0F1923),
          child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 12, bottom: 0, left: 12, right: 12),
                child: Image.asset(itemList[index]['img'], height: 84)
            ),
            ListTile(
              title: Row(children: [
            Visibility(
            visible: itemList[index]['creds'].toString() != 'Free',
                child: Padding(
                  padding: EdgeInsets.only(right: 4, bottom: 2),
                    child: Image.asset('assets/Creds.png', height: 8, width: 8)
                )
            ),
                Text(itemList[index]['creds'].toString().toUpperCase(), style: TextStyle(color: Colors.white),)
              ]),
              subtitle: Text(
                  itemList[index]['name'].toString().toUpperCase(),
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            )
          ]),
        );
      },
    );
  }

  Future<void> _populateList() async {
    String body = await rootBundle.loadString('assets/weapons.json');
    _weaponList = json.decode(body);

    setState(() {});
  }
}