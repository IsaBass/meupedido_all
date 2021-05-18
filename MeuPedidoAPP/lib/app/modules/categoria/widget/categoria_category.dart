import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import '../categoria_controller.dart';

class CategCategory extends StatefulWidget {
  final CategoriaModel categ;

  const CategCategory({Key key, this.categ}) : super(key: key);

  @override
  _CategCategoryState createState() => _CategCategoryState();
}

class _CategCategoryState extends State<CategCategory> {
  final CategoriaController _controller = Modular.get();

  void _onTap() {
    if (widget.categ.codCateg != _controller.codCategSelecionada) {
      _controller.setCategSelecionada(widget.categ.codCateg);
    }
  }

  @override
  Widget build(BuildContext context) {
    var categ = widget.categ;
    return InkWell(
      onTap: _onTap,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 6.0,
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
              SizedBox(width: 10),
              Observer(builder: (_) {
                return Text(
                  "${categ.descricao}",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: categ.codCateg == _controller.codCategSelecionada
                        ? Theme.of(context).accentColor
                        : Theme.of(context).textTheme.headline6.color,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
