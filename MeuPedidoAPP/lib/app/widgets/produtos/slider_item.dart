import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'favorito.botao.dart';
// import 'package:restaurant_ui_kit/screens/details.dart';
// import 'package:restaurant_ui_kit/util/const.dart';

class SliderItem extends StatefulWidget {
  final ProdutoModel prod;

  final double rating;
  final int raters;

  SliderItem({Key key, this.rating, this.raters, @required this.prod})
      : super(key: key);

  @override
  _SliderItemState createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  final formatMoeda = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              _imgProduto(context),
              _transparenteFundo(context),
              _nomeProdutoClaro(),
              _precoAnterior(),
              _precoProduto(),
              //_botaoComprar(),
              Positioned(
                  left: -10.0,
                  top: 3.0,
                  child: BtnFavorito(codigoProduto: widget.prod.codigo)),
            ],
          ),
          //_nomeProduto(),
          //_avaliacaoProduto(),
        ],
      ),
      onTap: () => Modular.to.pushNamed('/proddetail/${widget.prod.codigo}'),
    );
  }

  Widget _transparenteFundo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          //stops: [0,10],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black54],
        ),
      ),
    );
  }

  Widget _nomeProdutoClaro() {
    return Positioned(
      left: 12,
      bottom: 12,
      child: Container(
        padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
        width: 260, //  MediaQuery.of(context).size.width,
        child: Text(
          // 'Filé ao molho madeira e coisa de aspargo e etc',
          "${widget.prod.descricao}",
          style: TextStyle(
              fontSize: 19.0, fontWeight: FontWeight.w900, color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _precoProduto() {
    return Positioned(
      right: 20,
      bottom: 60,
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
        width: 200,
        child: Transform.rotate(
          angle: pi / 12,
          child: Text(
            '${formatMoeda.format(widget.prod.precoAtual)}',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
                color: Colors.yellowAccent,
                shadows: [Shadow(color: Colors.black, blurRadius: 20)]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _precoAnterior() {
    if (widget.prod.precoDe == 0.0 ||
        widget.prod.precoDe <= widget.prod.precoAtual) {
      return Container();
    }
    return Positioned(
      right: 20,
      bottom: 90,
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
        width: 200,
        child: Transform.rotate(
          angle: pi / 12,
          child: Text(
            'de: ${formatMoeda.format(widget.prod.precoDe)}',
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
              decorationStyle: TextDecorationStyle.solid,
              decorationThickness: 2,
              fontSize: 15.0,
              color: Colors.white,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _imgProduto(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.37,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: agImageProvider(
            imgUrl: widget.prod.img,
            imgTipo: widget.prod.imgTipo,
            fit: BoxFit.cover),
        // Image.asset(      "$img",     fit: BoxFit.cover     ),
      ),
    );
  }

  // Widget _botaoComprar() {
  //   return Positioned(
  //     bottom: 15,
  //     right: 12,
  //     child: Container(
  //       height: 30,
  //       width: 120,
  //       child: RaisedButton(
  //         color: Colors.green[600],
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text('Adicionar', style: TextStyle(color: Colors.white)),
  //             Icon(
  //               Icons.add_shopping_cart,
  //               color: Colors.white,
  //             ),
  //           ],
  //         ),
  //         onPressed: () {},
  //       ),
  //     ),
  //   );
  // }

}
