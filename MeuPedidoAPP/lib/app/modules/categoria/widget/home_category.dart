import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

//
class HomeCategory extends StatefulWidget {
  final CategoriaModel categ;

  const HomeCategory({Key key, this.categ}) : super(key: key);

  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  void _onTap() {
    //
    if (kIsWeb) {
      Modular.to.pushNamed('categoria/categ/${widget.categ.codCateg}');
    } else {
      Modular.to.navigate('categ/${widget.categ.codCateg}');
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    var categ = widget.categ;
    return InkWell(
      onTap: _onTap,
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
              Text(
                "${categ.descricao}",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
              ),
              // SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
