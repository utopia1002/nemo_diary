import 'package:flutter/material.dart';

Widget boxPreview(customBox, alignfactor) {
  return Column(
    children: <Widget>[customBox],
    mainAxisAlignment: alignfactor,
  );
}

Widget customBox(size, radius, text, textoption) {
  return Container(
    width: size[0],
    height: size[1],
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.5),
        borderRadius: radius),
    child: customText(text, textoption[0], textoption[1], textoption[2], textoption[3]),
  );
}

Widget customText(text, size, weight, color, align) {
  return Center(
    child: Column(
      children: <Widget>[
        Text(
          text.toString(),
          textAlign: align,
          style: TextStyle(fontWeight: weight, color: color),
          textScaleFactor: size,
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  );
}