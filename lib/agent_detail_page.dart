import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laborant/sliver_appbar_title.dart';

class AgentDetailPage extends StatefulWidget {

  Map agent;

  AgentDetailPage({Key key, @required this.agent}) : super();

  @override
  createState() => new AgentDetailPageState(agent: agent);
}

class AgentDetailPageState extends State<AgentDetailPage> {

  Map agent;

  AgentDetailPageState({Key key, @required this.agent}) : super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1923),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            //brightness: Brightness.dark,
            //iconTheme: ThemeData.dark().iconTheme,
            //backgroundColor: Color(0xFF0F1923),
            expandedHeight: 360,
            pinned: true,
            floating: false,
            centerTitle: true,
            leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: () => Navigator.of(context).pop()),
            title: SliverAppBarTitle(
                child: Text(agent['name'].toString().toUpperCase())
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.pin,
              background: Container(
                  margin: EdgeInsets.only(top: 56),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          right: -64,
                          top: 48,
                          child: Image.asset(agent['img'], width: 380, fit: BoxFit.cover)
                      ),
                      Positioned(
                        top: 320,
                        left: 0,
                        child: Card(
                          margin: EdgeInsets.all(0),
                          color: Color(0xFF0F1923),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 42,
                        left: 18,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(agent['name'].toString().toUpperCase(),
                                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700)),
                                Chip(
                                  label: Text(agent['type'], style: TextStyle(color: Colors.white70)),
                                  backgroundColor: Color(0xFF273039),
                                ),
                              ])
                      ),
                    ],
                  )
              ),
            ),
          )
        ],
        body: SingleChildScrollView(
            physics: new ClampingScrollPhysics(),
              child: Container(
              color: Color(0xFF0F1923),
              margin: EdgeInsets.all(0),
              child: _buildBody(),
            )
        )
      )
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(top: 0, bottom: 4, left: 12, right: 12),
        child:Column(
      children: <Widget>[
        _buildAbility(agent['abilities'][0]),
        _buildAbility(agent['abilities'][1]),
        _buildAbility(agent['abilities'][2]),
        _buildAbility(agent['abilities'][3])
      ],
    )
    );
  }

  Widget _buildAbility(Map ability) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: ListTile(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ability['name'].toString().toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.white)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Visibility(
                    visible: ability['type'].toString() != 'Ultimate' && ability['cost'] != 'Free',
                    child: Image.asset('assets/Creds.png', height: 6, width: 6),
                  ),
                  Text(ability['cost'].toString().toUpperCase(), style: TextStyle(fontSize: 14, color: Colors.white))
                ])
              ]
          ),
          leading: Image.asset(ability['img']),
          subtitle: Text(ability['description'], textAlign: TextAlign.start, style: TextStyle(fontSize: 12, color: Colors.white60))
      )
    );
  }
}