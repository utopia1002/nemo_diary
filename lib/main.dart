import 'package:flutter/material.dart';
import 'box/boxes.dart';
import 'listview/listview.dart';
import 'detailScreen.dart';
import 'box/colors.dart';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

int pagenumber;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        title: 'Nemo Diary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue
        ),
        home: home(),

    );
  }
}

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    pagenumber = 0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.list), iconSize: 50,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context)=> ListViewMain()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), iconSize: 50, color: Colors.white,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailPage(pagenumber: pagenumber)
                  )
              );
            },
          )
        ],
      ),
      body: baseState(),
    );
  }
}

class baseState extends StatefulWidget {
  @override
  _baseState createState() => _baseState();
}

class _baseState extends State<baseState> {

  String textinbox = "SHOW ME WHAT YOU GOT";

  Widget build(BuildContext context) {
    return mainPage();
  }

  Widget mainPage() {

    var backgroundRandomControl = new Random();
    var backgroundRandom = colors[backgroundRandomControl.nextInt(colors.length)];

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors : backgroundRandom,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        alignment: Alignment.center,
        child: Container(
          child: PageView.builder(
              itemBuilder: (context, position){
                return boxes[position];
              },
              itemCount: boxes.length,
              onPageChanged: (context){
                pagenumber = context;
                setState(() {
                  backgroundRandom = colors[backgroundRandomControl.nextInt(colors.length)];
                });
              },
          )
        )
    );
  }
}