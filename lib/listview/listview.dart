import 'package:flutter/material.dart';
import '../main.dart';
import '../data/views.dart';
import '../box/boxes.dart';
import '../box/colors.dart';

class ListViewMain extends StatefulWidget{

  @override
  _ListViewMainState createState() => _ListViewMainState();
}

class _ListViewMainState extends State<ListViewMain> {
  List savedList;
  int currentDiaryId;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'ListView',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.blue
      ),
      home: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => home()
                ));
              }),
          actions: <Widget>[IconButton(icon: Icon(Icons.delete),
            onPressed: (){
              DiaryDelete(currentDiaryId, context);
            },
          )],
        ),
        body : getsavedList(),
      )
    );
  }

  void refresh(){
    setState((){});
  }

  Future<void> getList() async{
    DBHelper pen = DBHelper();
    return await pen.getDiary();
  }

  Widget getsavedList(){
    return FutureBuilder(
      future: getList(),
      builder: (context, snapshot){
        return PageView.builder(
            itemBuilder: (BuildContext context, int index){
              currentDiaryId = snapshot.data[index].id;
              return Container(
                child:
                  Column(
                    children: <Widget>[
                      SizedBox(),
                      boxViewbuilder(snapshot.data[index].boxnumber, snapshot.data[index].content),
                      Text(snapshot.data[index].date, textAlign: TextAlign.right, style: TextStyle(color: Colors.white))
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors[snapshot.data[index].color],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                ),
                alignment: Alignment.center,
              );
            }, itemCount: snapshot.data.length, );
      },
    );
  }

  Future<void> DiaryDelete(currentDiaryId, context) async{
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: Text("정말 지울까요?"),
          actions: <Widget>[
            FlatButton(
              child: Text("예", style: TextStyle(color: Colors.red),),
              onPressed: (){
                  _deleteDiary(currentDiaryId, context);
                },
            ),
            FlatButton(
              child: Text("돌아가기", style: TextStyle(color: Colors.black),),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  Future<void> _deleteDiary(id, context) async{
    DBHelper pen = DBHelper();
    await pen.deleteDiary(id);
    refresh();
    Navigator.of(context).pop();
  }
}