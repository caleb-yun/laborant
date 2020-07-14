import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeaponsPage extends StatefulWidget {
  @override
  createState() => new WeaponsPageState();
}

class WeaponsPageState extends State<WeaponsPage> {
  Map _weaponList = {};
  BuildContext _scaffoldContext;

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
            leading: IconButton(
                icon: Icon(CupertinoIcons.back),
                onPressed: () => Navigator.of(context).pop()),
            bottom: TabBar(isScrollable: true, tabs: <Widget>[
              Tab(text: 'SIDEARM'),
              Tab(text: 'SMG'),
              Tab(text: 'SHOTGUN'),
              Tab(text: 'RIFLE'),
              Tab(text: 'SNIPER'),
              Tab(text: 'HEAVY')
            ]),
          ),
          body: Builder(builder: (context) {
            _scaffoldContext = context;
            return TabBarView(
              children: <Widget>[
                _buildList(_weaponList['sidearm']),
                _buildList(_weaponList['smg']),
                _buildList(_weaponList['shotgun']),
                _buildList(_weaponList['rifle']),
                _buildList(_weaponList['sniper']),
                _buildList(_weaponList['heavy'])
              ],
            );
          }),
        ));
  }

  Widget _buildList(List itemList) {
    return ListView.builder(
      padding: EdgeInsets.all(24),
      itemCount: itemList == null ? 0 : itemList.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Color(0xFF0F1923),
          //color: Color(0xff34ca95),
          margin: EdgeInsets.only(bottom: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          child: InkWell(
              onTap: () {
                _showWeaponDetail(itemList[index]);
              },
              child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 24, bottom: 0, left: 12, right: 12),
                    child: Ink.image(
                        image: AssetImage(itemList[index]['img']), height: 84)),
                ListTile(
                  title: Row(children: [
                    Visibility(
                        visible: itemList[index]['creds'].toString() != 'Free',
                        child: Padding(
                            padding: EdgeInsets.only(right: 4, bottom: 2),
                            child: Image.asset('assets/Creds.png',
                                height: 8, width: 8))),
                    Text(
                      itemList[index]['creds'].toString().toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    )
                  ]),
                  subtitle: Text(
                    itemList[index]['name'].toString().toUpperCase(),
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                )
              ])),
        );
      },
    );
  }

  void _showWeaponDetail(Map weapon) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: _scaffoldContext,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16))),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  padding:
                      EdgeInsets.only(top: 48, bottom: 48, left: 32, right: 32),
                  child: Image.asset(weapon['img'], height: 72)),
              Text(
                weapon['name'].toString().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              ListTile(
                title: Text('Primary Fire'),
                subtitle: Text(weapon['primaryFire']),
              ),
              Visibility(
                visible: weapon.containsKey('alternateFire'),
                child: ListTile(
                  title: Text('Alternate Fire'),
                  subtitle: Text(weapon.containsKey('alternateFire')
                      ? weapon['alternateFire']
                      : ''),
                ),
              ),
              ListTile(title: Text('Damage'), subtitle: Text(weapon['damage'])),
              Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Row(children: [
                    Expanded(
                      child: ListTile(
                          title: Text('Magazine Capacity'),
                          subtitle: Text(weapon['magazine'])),
                    ),
                    Expanded(
                      child: ListTile(
                          title: Text('Wall Penetration'),
                          subtitle: Text(weapon['wallPenetration'])),
                    )
                  ]))
            ]),
          );
        });
  }

  Future<void> _populateList() async {
    String body = await rootBundle.loadString('assets/weapons.json');
    _weaponList = json.decode(body);

    setState(() {});
  }
}
