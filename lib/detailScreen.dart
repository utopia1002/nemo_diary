import 'package:flutter/material.dart';
import 'main.dart';
import 'box/boxes.dart';
import 'data/models.dart';
import 'data/views.dart';
import 'listview/listview.dart';
import 'box/colors.dart';

int currentpage;
int colornumber;
String InitText;

class DetailPage extends StatelessWidget{

  Color background = Colors.transparent;

  DetailPage({Key key, @required pagenumber}) : super(key:key);

  @override
  Widget build(BuildContext context) {

    InitText = "Show me What you got";

    currentpage = pagenumber;

    return MaterialApp(
        title: 'Nemo Diary',
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
              leading: IconButton(icon: Icon(Icons.arrow_back), iconSize: 40, color: Colors.white,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => home())
                  );
                },
              ),
              actions: <Widget>[
                IconButton(icon :Icon(Icons.mode_edit), iconSize: 40, color: Colors.white,
                    onPressed: ()=> write(context)),
              ],
            ),
            body: boxwritebase()
        )
    );
  }

  Future<void> write(BuildContext context) async{

    var _date = DateTime.now();
    var _dateY = _date.year.toString();
    var _dateM = _date.month.toString().padLeft(2, '0');
    var _dateD = _date.day.toString().padLeft(2, '0');

    var _convDate = "$_dateY - $_dateM - $_dateD";

    Future<void> save() async{
      DBHelper pen = DBHelper();
      Diary newDiary = Diary(
        content: InitText,
        boxnumber: pagenumber,
        color: colornumber,
        date: _convDate,
      );
      await pen.createDiary(newDiary);
    }

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("이 박스를 저장할까요?"),
            actions: <Widget>[
              FlatButton(
                child: Text("YES"),
                onPressed: (){
                  save();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> ListViewMain()));
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){
                  Navigator.pop(context, "Cancel");
                },
              )
            ],
          );
        }
    );
  }

}
class boxwritebase extends StatefulWidget{
  @override
  _boxwritestate createState() => _boxwritestate();
}

class _boxwritestate extends State<boxwritebase>{

  var pickerWidth = 240.0;
  bool pickerSelect = false;
  List<Color> initColor;

  TextEditingController _textcontroller = TextEditingController();

  Widget build(BuildContext context){
    return mainPage();
  }

  Widget mainPage(){
    return Stack(
      children: <Widget>[
        mainPageContent(),
        Positioned(right: 10, top: 80, child: colorSelect()),
        Positioned(right: 60, top: 80, child: colorPicker()),
      ],

    );
  }

  Widget colorSelect(){
    return Container(
      child: RawMaterialButton(
        onPressed: (){
          setState((){
            pickerSelect = !pickerSelect;
          });
        },
        elevation: 3.0,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        constraints: BoxConstraints.tightForFinite(),
        child: Icon(Icons.color_lens, color: Colors.white, size: 30,),
      ),
    );
  }

  Widget colorPicker(){
    return AnimatedContainer(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){
          if(index.isEven){
            return RawMaterialButton(
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors[index ~/ 2],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft
                  ),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white),
                ),
                height: 30,
                width: 30,
              ),
              elevation: 2.0 ,
              onPressed: (){
                setState(() {
                  initColor = colors[index ~/ 2];
                  colornumber = index ~/ 2;
                });
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.tightForFinite(),
            );
          }
          return SizedBox(width: 5.0);
        },
        itemCount: colors.length * 2,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
      ),
      height: 30.0,
      width: pickerSelect? pickerWidth: 0,
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tightForFinite(),
    );
  }

  Widget mainPageContent() {

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: initColor == null ? initColorSample : initColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
        alignment: Alignment.center,
        child: Container(
          child: PageView(
            children: <Widget>[
              boxPreview(_textcontroller, InitText),
            ],
          ),
          alignment: Alignment.center,
        )
    );
  }

  Widget boxPreview(textcontroller, text){

    void setText(text){
      setState((){
        InitText = text.toString();
      });
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        boxViewbuilder(pagenumber, InitText),
        Positioned(
          child: TextField(
            controller: textcontroller,
            maxLines: 4,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: "이곳을 탭하여 글쓰기",
              labelStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (context){
              InitText = context;
              setText(_textcontroller.text);
            },
            cursorColor: Colors.white,
          ),
          top: 50,
          width: 300,
        )
      ],
    );
//    return Column(
//      children: <Widget>[
//        boxViewbuilder(pagenumber, InitText),
//        TextField(
//          controller: textcontroller,
//          maxLines: 4,
//          textAlign: TextAlign.center,
//          decoration: InputDecoration(
//            suffixIcon: IconButton(
//              icon: Icon(Icons.send),
//              color: Colors.white,
//              onPressed: (){
//                setText(_textcontroller.text);
//              },
//            ),
//            labelText: "아래를 탭하여 글쓰기",
//            labelStyle: TextStyle(color: Colors.white),
//          ),
//          style: TextStyle(color: Colors.white),
//          onChanged: (context){
//            InitText = context;
//            setText(_textcontroller.text);
//          },
//          cursorColor: Colors.white,
//        ),
//      ],
//      mainAxisAlignment: MainAxisAlignment.center,
//      mainAxisSize: MainAxisSize.max,
//    );
  }
}