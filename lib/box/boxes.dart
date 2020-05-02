import 'package:flutter/material.dart';
import 'package:nemo_diary/models.dart';

String initText = "Show Me What You Got";

//새 박스 추가 시 boxes, box, boxstyle, _custombox, custombox 추가필요

final boxes = [box1, box2, box3, box4];

final box1 = boxPreview(custombox1, MainAxisAlignment.center);
final box2 = boxPreview(custombox2, MainAxisAlignment.center);
final box3 = boxPreview(custombox3, MainAxisAlignment.center);
final box4 = boxPreview(custombox4, MainAxisAlignment.center);

final boxStyle = {
  "style1": [2.5, FontWeight.w700, Colors.white, TextAlign.center],
  "style2": [1.5, FontWeight.w700, Colors.white, TextAlign.center],
  "style3": [1.5, FontWeight.w600, Colors.white, TextAlign.center],
};

final customboxobject = [_custombox1, _custombox2, _custombox3, _custombox4];

List _custombox1 = [[180.0, 180.0], BorderRadius.circular(0), boxStyle['style1']];
List _custombox2 = [[180.0, 360.0], BorderRadius.circular(0), boxStyle['style1']];
List _custombox3 = [[210.0, 360.0], BorderRadius.circular(0), boxStyle['style2']];
List _custombox4 = [[300.0, 360.0], BorderRadius.circular(1.0), boxStyle['style3']];

Widget boxbuilder(boxoption, text){
  return customBox(boxoption[0], boxoption[1], text, boxoption[2]);
}

Widget boxViewbuilder(boxnumber, text){
  return boxbuilder(customboxobject[boxnumber], text);
}

final custombox1 = boxbuilder(_custombox1, initText);
final custombox2 = boxbuilder(_custombox2, initText);
final custombox3 = boxbuilder(_custombox3, initText);
final custombox4 = boxbuilder(_custombox4, initText);

Widget boxWrite(boxpreview,textcontroller){
  return Column(
    children: <Widget>[
      boxpreview,
    ],
  );
}

Widget boxEditor(TextEditingController textcontoller, maxlines){
  return TextField(
    controller: textcontoller,
    maxLines: maxlines,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: (){}
      )
    ),
  );
}


