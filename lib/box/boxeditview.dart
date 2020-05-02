import 'package:flutter/material.dart';

List pickerCircle = [picker1, picker2, picker3];

final picker1 = colorPickerCircle(Colors.black);
final picker2 = colorPickerCircle(Colors.blueAccent);
final picker3 = colorPickerCircle(Colors.deepOrange);

Widget colorPickerCircle(Color color){
  return Container(
    child: RawMaterialButton(
      onPressed: (){

      },
      elevation: 3.0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints.tightForFinite(),
      child: Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100.0),
        ),
        width: 30.0,
        height: 30.0,
      ),
    ),
  );
}
