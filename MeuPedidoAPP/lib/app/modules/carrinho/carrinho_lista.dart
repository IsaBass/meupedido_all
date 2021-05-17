import 'package:MeuPedido/app/modules/home/home_controller.dart';
import 'package:MeuPedido/app/modules/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/janela.pergunta.dart';

import 'carrinho_controller.dart';
import 'widget/btns_carrinho.dart';
import 'widget/card.cartitem.dart';
import 'widget/painel_resumo.dart';

class CarrinhoListaPage extends StatefulWidget {
  @override
  _CarrinhoTabListaState createState() => _CarrinhoTabListaState();
}

class _CarrinhoTabListaState extends State<CarrinhoListaPage> {
  final HomeController _homeController = HomeModule.to.get<HomeController>();

  final CartController _cartController = Modular.get<CartController>();
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();

  final TextEditingController _cupomEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _cupomEditController.text =
        _cartController.cartAtual?.cupomAplicado?.tagCupom ?? '';
    return Scaffold(
      appBar: AppBar(title: Text('Sua seleção'), centerTitle: true),
      // bottomNavigationBar: Observer(
      //   builder: (_) {
      //     return _cartController.cartAtual.itens?.length == 0
      //         ? Container(height: 0)
      //         : _barraCompra(context);
      //   },
      // ),
      body: Observer(builder: (_) {
        return _cartController.cartAtual.itens?.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.cartArrowDown, size: 100),
                    SizedBox(height: 25),
                    Text('Carrinho Vazio!'),
                    SizedBox(height: 25),
                    _btnContinuarComprando(context)
                  ],
                ),
              )
            : Column(
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Container(height: 50, child: Text('aqui esta seu carrinho')),
                  Expanded(
                    child: ListView(
                      //shrinkWrap: true,
                      children: [
                        _listaItens(),
                        _btnContinuarComprando(context),
                        _cupomDesconto(),
                        _painelResumo(),
                        _botaoFecharComprar(context),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget _cupomDesconto() {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 2,
        borderOnForeground: true,
        child: Container(
          child: ExpansionTile(
            title: Text('Tem cupom de desconto?',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText2.color)),
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 2, 8),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
                decoration: BoxDecoration(border: Border.all(width: 1)),
                child: TextFormField(
                  controller: _cupomEditController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(FontAwesomeIcons.moneyCheckAlt),
                    suffixIcon: Observer(builder: (_) {
                      if (_carrinhoController.isLoadingCupom) {
                        return Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 30,
                          child: exibeCarregandoCircular(
                              isLoading: _carrinhoController.isLoadingCupom),
                        );
                      }
                      switch (_carrinhoController.cupomAceito ?? '') {
                        case 'S':
                          return Icon(FontAwesomeIcons.checkCircle,
                              color: Colors.green);
                          break;
                        case 'N':
                          return Icon(FontAwesomeIcons.exclamationCircle,
                              color: Colors.red);
                          break;
                        default:
                          return Text('');
                      }
                    }),
                    hintText: 'Digite seu Cupom de Desconto',
                    labelText: 'Cupom de Desconto',
                    // helperText: widget.helperText,
                  ),
                  onFieldSubmitted: (value) async {
                    var retorno = await _carrinhoController.getCupom(value);
                    if (retorno == null) return;
                    if (retorno['aceito'] == false) {
                      showPergunta(
                        title: 'Cupom não aceito',
                        desc: retorno['message'],
                        botaoSim: '',
                        botaoNao: 'OK',
                        context: context,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnContinuarComprando(BuildContext context) {
    return BtnsCarrinho(
      buttomLabel: "Continuar Comprando",
      icone: FontAwesomeIcons.shoppingBasket,
      onPressed: () => _homeController.pageController.jumpToPage(0),
    );
  }

  Widget _botaoFecharComprar(BuildContext context) {
    return BtnsCarrinho(
      buttomLabel: "Finalizar Compra",
      icone: Icons.monetization_on,
      onPressed: () => Modular.to.pushNamed('/cart/finaliza'),
    );
  }

  Widget _listaItens() {
    return Observer(builder: (_) {
      return Column(
        // children: _appController.cartAtual.itens
        children: _cartController.cartAtual.itens
            .map((item) => CardCartItem(item: item))
            .toList(),
      );
    });
  }

  Widget _painelResumo() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '  Resumo da Compra:',
              style: TextStyle(fontSize: 12),
            ),
            Card(child: CartPainelResumo()),
          ],
        ));
  }
}
