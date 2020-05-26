import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laborant/agents_page.dart';
import 'package:laborant/weapons_page.dart';

class GuidesPage extends StatefulWidget {

  @override
  createState() => new GuidesPageState();

}

class GuidesPageState extends State<GuidesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GUIDES'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.of(context).pop()
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildItem('Agents', 'assets/agents.jpg', (context) => AgentsPage()),
          _buildItem('Weapons', 'assets/weapons.jpg', (context) => WeaponsPage()),
          _buildItem('Maps', 'assets/maps.jpg', (context) => AgentsPage()),
        ],
      )
    );
  }

  Widget _buildItem(String title, String imgPath, WidgetBuilder builder) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(18),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: builder));
          },

          child: Ink(
              height: 220,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF0F1923),
                  /*image: DecorationImage(
                      image: AssetImage(imgPath), fit: BoxFit.cover)*/
              ),
              child: Center(child: Text(
                  title.toUpperCase(),
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, color: Colors.white70)
              ))
          )
      )
    );
  }

}