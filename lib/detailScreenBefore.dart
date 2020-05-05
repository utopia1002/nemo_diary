import 'package:flutter/material.dart';
import 'main.dart';
import 'box/boxes.dart';
import 'data/models.dart';
import 'data/views.dart';
import 'listview/listview.dart';
import 'box/boxeditview.dart';

int currentpage;

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
              leading: IconButton(icon: Icon(Icons.arrow_back), iconSize: 30, color: Colors.indigoAccent,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => home())
                  );
                },
              ),
              actions: <Widget>[
                IconButton(icon :Icon(Icons.mode_edit), iconSize: 30, color: Colors.indigoAccent,
                    onPressed: ()=> write(context)),
              ],
            ),
            body: boxwritebase()
        )
    );
  }
  
  Future<void> write(BuildContext context) async{

    Future<void> save() async{
      DBHelper pen = DBHelper();
      Diary newDiary = Diary(
        content: InitText,
        boxnumber: pagenumber,
        color: 1,
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

  var pickerWidth = 200.0;
  bool pickerSelect = false;

  TextEditingController _textcontroller = TextEditingController();

  Widget build(BuildContext context){
    return mainPage();
  }

  Widget mainPage(){
    return Stack(
      children: <Widget>[
        mainPageContent(),
        Positioned(right: 10, top: 80, child: colorSelect()),
        Positioned(right: 50, top: 80, child: colorPicker()),
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
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.deepPurpleAccent, Colors.yellowAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,),
            borderRadius: BorderRadius.circular(100.0),
          ),
          width: 30.0,
          height: 30.0,
        ),
      ),
    );
  }

  Widget colorPicker(){
    return AnimatedContainer(
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            if(index.isEven){
              return pickerCircle[index ~/ 2];
            }
            return SizedBox(width: 5.0);
          },
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
      ),
      height: 30.0,
      width: pickerSelect? pickerWidth: 0,
      duration: Duration(milliseconds: 200),
    );
  }

  Widget mainPageContent() {
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
          alignment: Alignment.center,
        )
    );
  }

  Widget boxTest(textcontroller, text){

    void setText(text){
      setState((){
        print("setSTate");
        InitText = text.toString();
      });
    }

    return Column(
      children: <Widget>[
        boxViewbuilder(pagenumber, InitText),
        TextField(
          controller: textcontroller,
          maxLines: 4,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: (){
                  setText(_textcontroller.text);
                },
              ),
              labelText: "Spit your mind"
          ),
          onChanged: (context){
            print(context);
            InitText = context;
            setText(_textcontroller.text);
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
    );
  }
}