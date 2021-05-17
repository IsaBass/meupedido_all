import 'package:MeuPedido/app/app_module.dart';
import 'package:MeuPedido/app/categs/categs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'categoria_category.dart';

class SeletorCategoriaCateg extends StatefulWidget {
  const SeletorCategoriaCateg({Key key}) : super(key: key);
  @override
  _SeletorCategoriaState createState() => _SeletorCategoriaState();
}

class _SeletorCategoriaState extends State<SeletorCategoriaCateg> {
  final CategsController _categsController = Modular.get();

  @override
  void initState() {
    super.initState();
    //
    // _categsController.recarregaAllCategs();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Observer(builder: (_) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _categsController.categs == null
              ? 0
              : _categsController.categs.length,
          itemBuilder: (context, index) {
            return CategCategory(
              categ: _categsController.categs[index],
              //isHome: widget.isHome,
            );
          },
        );
      }),
    );
  }
}
