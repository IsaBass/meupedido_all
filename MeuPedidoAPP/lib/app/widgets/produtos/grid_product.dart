

// import 'package:MeuPedido/app/modules/home/widgets/smooth_star_rating.dart';
// import 'package:MeuPedido/app/utils/const.dart';
import 'package:MeuPedido/app/widgets/produtos/favorito.botao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';

Widget gridProdutos(BuildContext context, List<ProdutoModel> lista) {
  int qtd = (MediaQuery.of(context).size.width ~/ 130);

  return GridView.builder(
    shrinkWrap: true,
    primary: false,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: qtd,
      childAspectRatio: 2.7 / 3,
      mainAxisSpacing: 0,
      crossAxisSpacing: 10,
    ),
    itemCount: lista == null ? 0 : lista.length,
    itemBuilder: (context, index) =>
        GridProduct(prod: lista[index], qtdCols: qtd),
  );
}

class GridProduct extends StatelessWidget {
  final ProdutoModel prod;
  final int qtdCols;
  GridProduct({Key key, this.prod, this.qtdCols}) : super(key: key);
  final formatMoeda = NumberFormat.simpleCurrency(locale: 'pt_BR');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed('/proddetail/${prod.codigo}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // shrinkWrap: true,
        // primary: false,
        children: <Widget>[
          Flexible(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 125,
                  width: (MediaQuery.of(context).size.width / qtdCols),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: agImageProvider(
                        imgUrl: prod.img,
                        imgTipo: prod.imgTipo,
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  right: -17.0,
                  bottom: 3.0,
                  child: BtnFavorito(codigoProduto: prod.codigo),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.0, right: 5),
                  child: Text(
                    "${formatMoeda.format(prod.precoAtual)}",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0, top: 1.0, right: 5),
                  child: Text(
                    "${prod.descricao}",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900),
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
