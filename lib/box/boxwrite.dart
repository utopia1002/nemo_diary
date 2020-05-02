import 'package:flutter/material.dart';
import 'boxes.dart';
import '../main.dart';
import 'package:nemo_diary/models.dart';

class boxwriteMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Nemo Diary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.blue
        ),
        home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.arrow_back), iconSize: 30, color: Colors.indigoAccent,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => home())
                );
              },
            ),
            actions: <Widget>[
              IconButton(icon :Icon(Icons.mode_edit), iconSize: 30, color: Colors.indigoAccent,)
            ],
          ),
          body: boxwritebase()
        )
    );
  }
}

class boxwritebase extends StatefulWidget{
  @override
  _boxwritestate createState() => _boxwritestate();
}

class _boxwritestate extends State<boxwritebase>{

  TextEditingController _textcontroller = TextEditingController();

  String InitText = "SHOW ME WHAT YOU GOT";

  Widget build(BuildContext context){
     return mainPage();
  }

  Widget mainPage() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.yellowAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        alignment: Alignment.center,
        child: Container(
          child: PageView(
            children: <Widget>[
              boxTest(_textcontroller, InitText),
            ],
          ),
          constraints: BoxConstraints(maxWidth: 280, maxHeight: 400),
          alignment: Alignment.center,
        )
    );
  }

  Widget boxTest(textcontroller, text){

    void setText(text){
      setState((){
        InitText = text.toString();
      });
    }

    return Column(
      children: <Widget>[
        customBox(
          [180.0, 180.0],
          BorderRadius.circular(0),
          text, [2.5, FontWeight.w700, Colors.white, TextAlign.center]),
        TextField(
          controller: textcontroller,
          maxLines: 4,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: (){
                  setText(_textcontroller.text );
                },
              ),
              labelText: "Spit your mind"
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}