import 'package:MeuPedido/app/app_module.dart';
import 'package:MeuPedido/app/widgets/rounded_bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/janela.pergunta.dart';
import 'package:toast/toast.dart';

class CardCartItem extends StatefulWidget {
  final CartItemModel item;

  const CardCartItem({Key key, this.item}) : super(key: key);

  @override
  _CardCartItemState createState() => _CardCartItemState();
}

class _CardCartItemState extends State<CardCartItem> {
  // final AppController _appController = AppModule.to.get();

  // final AuthController _authController = AppModule.to.get();
  final CartController _cartController = AppModule.to.get();
  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    return RoundedContainer(
      margin: EdgeInsets.all(5),
      padding: const EdgeInsets.only(left: 0),
      borderRadius: BorderRadius.circular(10.0),
      //elevation: 4,
      child: Stack(
        children: [
          Container(
            // decoration:
            //     BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Row(
              children: [
                _imgProduto(item),
                SizedBox(width: 5),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      _nomeProduto(item),
                      //aqui o text com varias linhas de um get do cartItem com todos os opcionais marcados
                      _opcionais(item),
                      Row(
                        children: [
                          _rowQuantidade(item),
                          _precos(item),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -5,
            bottom: 0,
            child: IconButton(
                icon: FaIcon(FontAwesomeIcons.trashAlt,
                    size: 18, color: Colors.grey),
                onPressed: () async {
                  // var resp = await showPergunta(
                  //   context: context,
                  //   title: 'Excluir do carrinho?',
                  //   botaoSim: 'Excluir',
                  // );
                  // if (resp == false) return;

                  _cartController.removeCarrinho(
                      //_authController.userAtual.docRef,
                      item);
                  // _appController.removeCarrinho(item);
                  // Toast.show(
                  //   "Item removido do carrinho", context,
                  //   duration: Toast.LENGTH_LONG,
                  //   gravity: Toast.BOTTOM,
                  //   // backgroundColor: Colors.green
                  // );
                }),
          ),
        ],
      ),
    );
  }

  Widget _opcionais(CartItemModel item) {
    return Wrap(
      direction: Axis.horizontal,
      children: item.adics
          .map(
            (e) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 5),
                Icon(
                  FontAwesomeIcons.dotCircle,
                  color: Theme.of(context).accentColor,
                  size: 10,
                ),
                SizedBox(width: 3),
                Text(
                    "${e.quantidade > 0 ? ' + ' + e.quantidade.toStringAsFixed(0) : ''} ${e.descricao}"),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _nomeProduto(CartItemModel item) {
    return Text(
      '${item.produto.descricao}',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
    );
  }

  Widget _imgProduto(CartItemModel item) {
    return Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: agImageProvider(
          imgUrl: item.produto.img,
          imgTipo: item.produto.imgTipo,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _precos(CartItemModel item) {
    final moeda = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Observer(builder: (_) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text('Preço: R\$ ${item.vlrUnit.toStringAsFixed(2)}'),
          Text(
            '${moeda.format(item.vlrTot)}',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      );
    });
  }

  Widget _rowQuantidade(CartItemModel item) {
    return Observer(builder: (_) {
      return Row(
        children: [
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: item.quant > 1
                // ? () => _appController.decrementItem(item)
                ? () => _cartController.decrementItem(
                    //_authController.userAtual.docRef,
                    item)
                : null,
          ),
          Text('${item.quant.toStringAsFixed(0)}'),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => _cartController.incrementItem(
                //_authController.userAtual.docRef,
                item),
            // onPressed: () => _appController.incrementItem(item),
          ),
        ],
      );
    });
  }
}
