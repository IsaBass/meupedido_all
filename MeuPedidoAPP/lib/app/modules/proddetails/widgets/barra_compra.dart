import 'package:MeuPedido/app/app_module.dart';
import 'package:MeuPedido/app/modules/proddetails/proddetails_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:toast/toast.dart';

class BarraCompraDet extends StatelessWidget {
  ///
  final ProddetailsController controller;
  final ProdutoModel prod;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BarraCompraDet({Key key, this.controller, this.prod, this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = AppModule.to.get<AuthController>();
    var formatMoeda = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Observer(builder: (_) {
      return _authController.estaLogado
          ? Container(
              height: 50.0,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: Row(
                children: [
                  _linhaQuantidade(),
                  Expanded(child: _btnCompra(formatMoeda, context)),
                ],
              ),
            )
          : Container(
              height: 70.0,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: Row(
                children: [
                  _linhaQuantidade(),
                  Expanded(child: _btnLogarCompra(formatMoeda, context)),
                ],
              ),
            );
    });
  }

  Widget _btnLogarCompra(NumberFormat formatMoeda, BuildContext context) {
    return Container(
      //margin: EdgeInsets.all(10),
      child: RaisedButton.icon(
        icon: Icon(Icons.add_shopping_cart, color: Colors.white),
        label: Container(
          padding: EdgeInsets.all(6),
          child: Text(
            "Fazer Login\ne Comprar\n(${formatMoeda.format(controller.valorTotal)})",
            style: TextStyle(
              color: Theme.of(context).primaryTextTheme.headline6.color,
            ),
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: controller.quantidade <= 0.00
            ? null
            : () => _actLogarComprar(context),
      ),
    );
  }

  RaisedButton _btnCompra(NumberFormat formatMoeda, BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.add_shopping_cart, color: Colors.white),
      label: Text(
        "Adicionar   (${formatMoeda.format(controller.valorTotal)})",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: Theme.of(context).primaryColor,
      onPressed:
          controller.quantidade <= 0.00 ? null : () => _actComprar(context),
    );
  }

  Widget _linhaQuantidade() {
    return Row(
      children: [
        IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: controller.decrement),
        Text(
          '${controller.quantidade.toStringAsFixed(0)}',
          style: TextStyle(
              //color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: controller.increment),
      ],
    );
  }

  bool _validaAdcionais(BuildContext context) {
    if (prod.adicionaisValidados == false) {
      Toast.show("Opcionais Pendentes", context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.red);
      return false;
    }
    return true;
  }

  void _actComprar(BuildContext context) {
    if (!_validaAdcionais(context)) return;

    _adicionarProd();

    Toast.show("Produto Adicionado", context,
        duration: Toast.LENGTH_SHORT,
        gravity: Toast.CENTER,
        backgroundColor: Colors.teal[700]);

    Modular.to.pop();
  }

  void _actLogarComprar(BuildContext ctx) async {
    if (!_validaAdcionais(ctx)) return;

    var resp = await Modular.to.pushNamed('/login');

    if (resp ?? false) {
      _adicionarProd();

      // Toast.show("Produto Adicionado", ctx,
      //     duration: Toast.LENGTH_SHORT,
      //     gravity: Toast.CENTER,
      //     backgroundColor: Colors.teal[700]);

        Modular.to.pop();
    }
    ;
  }

  void _adicionarProd() {
    AppModule.to.get<CartController>().adicionarCarrinho(
          CartItemModel(
            idProduto: prod.codigo,
            quant: controller.quantidade,
            produto: prod,
            //vlrUnit: prod.precoAtual
          ),
        );
  }
}
