

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';

class CardProduto extends StatefulWidget {
  final ProdutoModel prod;

  const CardProduto({Key key, this.prod}) : super(key: key);

  @override
  _CardProdutoState createState() => _CardProdutoState();
}

class _CardProdutoState extends State<CardProduto> {
  // AppController _appController = AppModule.to.get();

  @override
  Widget build(BuildContext context) {
    var prod = widget.prod;
    return InkWell(
      onTap: () => Modular.to.pushNamed('/proddetail/${widget.prod.codigo}'),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
              child: Row(
                children: [
                  _imgProduto(prod),
                  //SizedBox(width: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _nomeProduto(),
                          _apresentacaoProduto(),
                          SizedBox(height: 3),
                          _precos(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //_favorito(),
          ],
        ),
      ),
    );
  }

  Text _nomeProduto() {
    return Text(
      '${widget.prod.descricao}',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
    );
  }

  Text _apresentacaoProduto() {
    return Text(
      '${widget.prod.descritivo}',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 13),
    );
  }

  Container _imgProduto(ProdutoModel produto) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: agImageProvider(
          imgUrl: produto.img,
          imgTipo: produto.imgTipo,
        ),
      ),
    );
  }

  Widget _precos() {
    final moeda = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${moeda.format(widget.prod.precoAtual)}',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        //Text('Total: R\$ ${item.vlrTot.toStringAsFixed(2)}'),
      ],
    );
  }
}

// Positioned _favorito() {
//   return Positioned(
//           right: -10.0,
//           bottom: 3.0,
//           child: RawMaterialButton(
//             onPressed: () {},
//             fillColor: Colors.white,
//             shape: CircleBorder(),
//             elevation: 4.0,
//             child: Padding(
//               padding: EdgeInsets.all(5),
//               child: Icon(
//                 // isFav
//                 //     ?Icons.favorite
//                 //     :
//                 Icons.favorite_border,
//                 color: Colors.red,
//                 size: 17,
//               ),
//             ),
//           ),
//         );
// }
