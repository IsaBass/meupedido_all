import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'manut_prods_controller.dart';
import 'manut_prods_module.dart';
import 'widgets/prods.seletorcategoria.dart';
import 'widgets/produto_tile.dart';

class ManutProdsPage extends StatefulWidget {
  final String title;
  const ManutProdsPage({Key key, this.title = "ManutProds"}) : super(key: key);

  @override
  _ManutProdsPageState createState() => _ManutProdsPageState();
}

class _ManutProdsPageState extends State<ManutProdsPage> {
  ///
  final ManutProdsController _controller = ManutProdsModule.to.get();

  ///

  @override
  void initState() {
    super.initState();

    _controller.recarregaAllCategs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          SeletorCategProdManut(),
          Observer(builder: (_) {
            return exibeCarregandoLinha(isLoading: _controller.isLoading);
          }),
          Flexible(
            child: Observer(builder: (_) {
              // if (_controller.isLoading) {
              //   return Center(child: CircularProgressIndicator());
              // }

              // if (_controller.prods == null || _controller.prods.length == 0) {
              //   return Center(child: Text('Sem Produtos'));
              // }

              // return Column(
              //   children: _controller.prods
              //       .map((prod) => ListTile(title: Text(prod.descricao)))
              //       .toList(),
              // );
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount:
                    _controller.prods == null ? 0 : _controller.prods.length,
                itemBuilder: (context, index) {
                  return ProdutoTile(
                    prod: _controller.prods[index],
                    idCateg: _controller.categSelecionada.docId,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
