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
            brightness: Brightness.dark,
            iconTheme: ThemeData.dark().iconTheme,
            backgroundColor: Color(0xFF0F1923),
            expandedHeight: 300,
            //elevation: 0,
            pinned: true,
            floating: false,
            centerTitle: true,
            leading: IconButton(icon: Icon(CupertinoIcons.back), onPressed: () => Navigator.of(context).pop()),
            title: SliverAppBarTitle(child: Text(
                agent['name'].toString().toUpperCase(),
              style: TextStyle(color: Colors.white))
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              collapseMode: CollapseMode.pin,
              background: Container(
                  margin: EdgeInsets.only(top: 56),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          right: -42,
                          top: 0,
                          child: Image.asset(agent['img'], width: 360, fit: BoxFit.cover)
                      ),
                      Positioned(
                        top: 48,
                        left: 18,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(agent['name'].toString().toUpperCase(),
                                    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700)),
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
        body: Card(
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        )
      )
    );
  }
}