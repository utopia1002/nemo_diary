import 'package:flutter/material.dart';

int HelpPage;

class helpScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("How to Use")
        ),
        body: Container(
          alignment: Alignment.center,
          child: helpMain(),
          color: Colors.grey,
        )
      )
    );
  }
  Widget helpMain(){
    List helpImage = [
      Image.asset('help1.jpg', fit: BoxFit.contain),
      Image.asset('help2.jpg', fit: BoxFit.contain),
      Image.asset('help3.jpg', fit: BoxFit.contain)
    ];
    return PageView.builder(
      itemBuilder: (BuildContext context, int index){

        HelpPage = index+1;
        return Stack(
          children: [
            Container(
              child: helpImage[index],
              constraints: BoxConstraints.expand(),
              color: Colors.white,
            ),
            Positioned.fill(
              child: Align(child: Text('$HelpPage / 3',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                textScaleFactor: 2.0,
              ), alignment: Alignment.bottomCenter),
              bottom: 30,
            )
          ],
        );
      },
      itemCount: 3,
    );
  }
}