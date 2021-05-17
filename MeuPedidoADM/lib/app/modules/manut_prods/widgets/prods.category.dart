import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:meupedido_core/meupedido_core.dart';

import '../manut_prods_controller.dart';
import '../manut_prods_module.dart';
// import 'package:restaurant_ui_kit/screens/categories_screen.dart';

class CategoryProds extends StatefulWidget {
  final CategoriaModel categ;
  // final bool isHome;

  const CategoryProds({Key key, this.categ}) : super(key: key);

  @override
  _CategoryProdsState createState() => _CategoryProdsState();
}

class _CategoryProdsState extends State<CategoryProds> {
  final ManutProdsController _controller = ManutProdsModule.to.get();

  @override
  Widget build(BuildContext context) {
    var categ = widget.categ;
    return InkWell(
      onTap: () => _controller.setCategSelecionada(widget.categ),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                getIconCategoria(categ.icone),
                size: 22,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 8.0),
              Observer(builder: (_) {
                return Text(
                  "${categ.descricao}",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: _controller.categSelecionada == categ
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.headline6.color,
                  ),
                );
              }),
              // SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
