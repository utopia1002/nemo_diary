import 'package:flutter/material.dart';
import '../main.dart';
import '../data/views.dart';
import '../box/boxes.dart';
import '../box/colors.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../history.dart';

class ListViewMain extends StatefulWidget{

  @override
  _ListViewMainState createState() => _ListViewMainState();
}

class _ListViewMainState extends State<ListViewMain> {
  List savedList;
  int currentDiaryId;
  File _imageFile;
  var globalKey = GlobalKey();

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
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => history()
                ));
              }
            ),
            IconButton(icon: Icon(Icons.add_a_photo),
              onPressed: (){
                _capture();
              },
            ),
            IconButton(icon: Icon(Icons.delete),
              onPressed: (){
                DiaryDelete(currentDiaryId, context);
              },
            )
          ],
        ),
        body : RepaintBoundary(
          key: globalKey,
          child: getsavedList()
        )
      )
    );
  }

  void permission() async{
    Map<PermissionGroup, PermissionStatus> permissions = await
    PermissionHandler().requestPermissions([PermissionGroup.storage]);
    print('permission : $permissions');
  }

  Future<void> _capture() async{
    var renderObject = globalKey.currentContext.findRenderObject();
    if(renderObject is RenderRepaintBoundary){
      permission();
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      File imgFile = new File('$directory/flutter_screenshot.png');
      final result = await ImageGallerySaver.saveImage(pngBytes);
      _capturePopup();
    };
  }

  void _capturePopup(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          content: Text("갤러리에 저장되었습니다"),
          actions: <Widget>[
            FlatButton(
              child: Text("확인"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void refresh(){
    setState((){});
  }

  Future<void> getList() async{
    DBHelper pen = DBHelper();

    var getScreen = await pen.getDiary();

    return getScreen;
  }

  Widget getsavedList(){
    return FutureBuilder(
      future: getList(),
      builder: (context, snapshot){
        Widget child;
        if(snapshot.data.length == 0){
          Widget emptyPage(){
            return Container(
              color: Colors.black38,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "기록이 비어있어요. \n무엇인가 기록해 보세요\n멋있는게 나올거에요",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                      child: Text("기록하러 가기", style: TextStyle(color: Colors.white),),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.blueAccent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MyApp()
                        ));
                      },
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            );
          }
          child = emptyPage();
        }
        else{
          child = PageView.builder(
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
        }
        return child;
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