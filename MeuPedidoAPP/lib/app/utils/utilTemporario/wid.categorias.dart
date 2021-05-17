import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

Widget seletorCategorias() {
  //HomeController _controller = HomeModule.to.get<HomeController>();

  Widget tileCategoria(String e) {
    return Observer(builder: (_) {
      return Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
            //  _controller.mudaCategAtiva(e);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              width: 80,
              height: 80,
              child: Text(e, style: TextStyle(fontSize: 50)),
              decoration: BoxDecoration(
               // color: _controller.categAtiva == e ? Colors.blue : Colors.amber,
                borderRadius: BorderRadius.circular(80),
              border: Border.all(width: 3, color: Colors.green ), 
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(2),
            width: 110,
            height: 30,
            child: Text(e, style: TextStyle(fontSize: 20)),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20), right: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)], 
            ),
          ),
        ],
      );
    });
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: ['1', '2', '3', '4', '5', '6', '7', '8', '10', '12', '14']
            .map(tileCategoria)
            .toList(),
      ),
    ),
  );
}
