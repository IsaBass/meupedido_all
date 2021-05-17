import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../manut_prods_controller.dart';
import '../manut_prods_module.dart';
import 'prods.category.dart';


class SeletorCategProdManut extends StatefulWidget {
  const SeletorCategProdManut({Key key}) : super(key: key);
  @override
  _SeletorCategoriaState createState() => _SeletorCategoriaState();
}

class _SeletorCategoriaState extends State<SeletorCategProdManut> {
  final ManutProdsController _controller = ManutProdsModule.to.get();

  @override
  void initState() {
    super.initState();
    //_categsController.recarregaAllCategs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Observer(builder: (_) {
        if (_controller.isLoadingList) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _controller.categs == null ? 0 : _controller.categs.length,
          itemBuilder: (context, index) {
            return CategoryProds(
              categ: _controller.categs[index],
              //isHome: widget.isHome,
            );
          },
        );
      }),
    );
  }
}
