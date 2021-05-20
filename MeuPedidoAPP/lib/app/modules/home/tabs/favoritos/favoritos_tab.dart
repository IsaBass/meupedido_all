import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/widgets/nao_logado.dart';
import 'package:MeuPedido/app/widgets/produtos/card.produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/janela.pergunta.dart';

import 'favoritos_controller.dart';

class FavoritosTab extends StatefulWidget {
  final String title;
  const FavoritosTab({Key key, this.title = "Seus Favoritos"})
      : super(key: key);

  @override
  _FavoritosTabState createState() => _FavoritosTabState();
}

class _FavoritosTabState
    extends ModularState<FavoritosTab, FavoritosController> {
  final AppController _appController = Modular.get();

  @override
  void initState() {
    controller.getProdutoFav();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos'), centerTitle: true),
      body: Observer(builder: (_) {
        if (!_appController.estaLogado) return NaoLogado();

        if (controller.isLoading) {
          return Center(
              child: exibeCarregandoCircular(isLoading: controller.isLoading));
        }
        if (controller.favs == null || controller.favs.length == 0) {
          return Center(child: Text('Sem Favoritos'));
        }

        return ListView(
          primary: false,
          shrinkWrap: true,
          children: controller.favs
              .map((e) => Stack(
                    children: [CardProduto(prod: e), _botaoExcluir(e)],
                  ))
              .toList(),
        );
      }),
    );
  }

  Positioned _botaoExcluir(ProdutoModel e) {
    return Positioned(
      right: 10,
      bottom: 0,
      child: IconButton(
        icon: Icon(Icons.delete_forever, color: Colors.grey),
        onPressed: () async {
          if (await showPergunta(
                title: 'Excluir favorito?',
                desc: 'Confirmação',
                context: context,
                //funcSim: () {},
              ) ==
              true) {
            controller.excluirFavorito(e);
          }

          ;
          // await showPergunta(
          //   desc: 'Excluir favorito?',
          //   title: 'Confirmação',
          //   context: context,
          //   funcSim: () =>  controller.excluirFavorito(e),
          // );
        },
      ),
    );
  }

  // Widget listaProdutos(BuildContext context) {
  //   FutureBuilder(
  //       future: fetchProdutos(),
  //       builder: (_, snap) {
  //         if (snap.connectionState == ConnectionState.waiting) {
  //           return (Center(
  //             child: exibeCarregandoCircular(),
  //           ));
  //         }

  //         if (snap.hasError) {
  //           return (Center(
  //             child: Text('ERRO AO PESQUISAR'),
  //           ));
  //         }

  //         // return snap.data[]
  //         return ListView(
  //           primary: false,
  //           shrinkWrap: true,
  //           children: snap.data.map((e) => CardProduto(prod: e)).toList(),
  //         );
  //       });
  // }

  // Widget _listaItens() {
  //   return Observer(builder: (_) {
  //     return Column(
  //       children: _appController.cartAtual.itens
  //           .map((item) => CardCartItem(item: item))
  //           .toList(),
  //     );
  //   });
  // }

}
