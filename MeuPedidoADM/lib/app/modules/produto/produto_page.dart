import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:meupedidoADM/app/modules/produto/tabs/prod.cadastro.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'produto_controller.dart';
import 'produto_module.dart';
import 'tabs/prod.opcionaistab.dart';

class ProdutoPage extends StatefulWidget {
  final ProdutoModel prod;
  final String title;
  final String idCateg;
  const ProdutoPage({Key key, this.title = "Produto", this.prod, this.idCateg})
      : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage>
    with SingleTickerProviderStateMixin {
  ///
  ProdutoModel prod;
  TabController _tabController;
  final ProdutoController _controller = ProdutoModule.to.get();

  final TextEditingController _nomeCont = TextEditingController();
  final TextEditingController _descritCont = TextEditingController();
  final TextEditingController _precoCont = TextEditingController();
  final formCadKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);

    //
    prod = widget.prod;
    _controller.getOpcionais(prod, widget.idCateg);
    _nomeCont.text = prod.descricao;
    _descritCont.text = prod.descritivo;
    _precoCont.text = prod.precoAtual.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prod.descricao),
        bottom: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          controller: _tabController,
          //unselectedLabelColor: Colors.grey,
          //labelColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(text: 'Cadastro'),
            Tab(text: 'Opcionais'),
          ],
        ),
      ),
      // bottomSheet: Container(height: 55, child: _botaoSalvar()),
      body: Column(
        children: [
          Observer(
            builder: (_) =>
                exibeCarregandoLinha(isLoading: _controller.isLoading),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      ProdTabCadastro(
                        formCadKey: formCadKey,
                        descritCont: _descritCont,
                        nomeCont: _nomeCont,
                        precoCont: _precoCont,
                        prod: prod,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(child: ProdTabOpcionais(prod: prod)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _botaoSalvar() {
  //   return Container(
  //     margin: EdgeInsets.all(5),
  //     width: double.infinity,
  //     child: RaisedButton(
  //       onPressed: () async {
  //         //
  //         if (!formCadKey.currentState.validate()) return;

  //         prod.precoAtual = double.parse(_precoCont.text);
  //         prod.descritivo = _descritCont.text;
  //         await _controller.saveProd(prod);

  //         Modular.to.pop();
  //         //
  //       },
  //       child: Text('Salvar'),
  //       color: Theme.of(context).primaryColor,
  //       textColor: Theme.of(context).primaryTextTheme.headline6.color,
  //     ),
  //   );
  // }

}
