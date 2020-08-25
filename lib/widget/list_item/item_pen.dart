import 'package:flutter/material.dart';

import '../stlye.dart';

Widget itemPen(int index, List numPen, List barnName, List idBarn, penNameController) {
  StyleApp  _styleApp = StyleApp();
  int ibBarn = idBarn[index];
  return Column(children: [
    Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: 20.0),
        child: Text(barnName[index], style: _styleApp.updatedStyle)),
    ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount:
        numPen[index].toString().isEmpty ? 0 : int.parse(numPen[index]),
        itemBuilder: (context, mIndex) {
          int count = mIndex + 1;
          String key = '[$ibBarn,$count]';
          penNameController[key] = TextEditingController();
          return Container(
              decoration:
              BoxDecoration(border: Border(bottom: _styleApp.borderside)),
              margin: EdgeInsets.only(
                  left: 36.0, right: 36.0, top: 16.0, bottom: 16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pen $key Name', style: _styleApp.lableTextName()),
                    TextField(
                        textCapitalization: TextCapitalization.words,
                        controller: penNameController[key],
                        decoration: InputDecoration(border: InputBorder.none))
                  ]));
        })
  ]);
}