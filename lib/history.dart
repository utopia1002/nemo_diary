import 'package:flutter/material.dart';
import 'data/views.dart';
import 'listview/listview.dart';

class history extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Nemo Diary",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ListViewMain()
              ));
            },
          ),
        ),
        body: Center(child: listViewer())
      ),
    );
  }

  Widget listViewer(){
    Future<void> getList() async{
      DBHelper pen = DBHelper();
      var getScreen = await pen.getDiary();
      return getScreen;
    }
    return FutureBuilder(
      future: getList(),
      builder: (context, snapshot){
        if(snapshot.data.length == 0){
          return Center(child: Text("EMPTY"));
        }
        return ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return Column(
                children: <Widget>[
                  Text(snapshot.data[index].content.toString().replaceAll('\n', "")),
                  Divider(color: Colors.grey, thickness: 1.5,)
                ],
              );
            },
            itemCount: snapshot.data.length,
            padding: EdgeInsets.only(left: 20, right: 20, top: 50),
        );
      },
    );
  }
}