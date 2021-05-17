import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:MeuPedido/app/widgets/produtos/card.produto.dart';
import 'package:MeuPedido/app/widgets/produtos/grid_product.dart';
import 'package:MeuPedido/app/widgets/produtos/slider_item.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'categoria_controller.dart';
import 'categoria_module.dart';
import 'widget/seletorcategoria.dart';

class CategoriaPage extends StatefulWidget {
  final String codCateg;
  final String title;
  const CategoriaPage({Key key, this.title = "Categoria", this.codCateg})
      : super(key: key);

  @override
  _CategoriaPageState createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  final CategoriaController _controller = Modular.get();

  bool tipoLista = false;

  @override
  void initState() {
    _controller.setCategSelecionada(int.parse(widget.codCateg));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) => Text(_controller.nomeSelecionada)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [SacolaButton()],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Observer(
              builder: (_) =>
                  exibeCarregandoLinha(isLoading: _controller.isLoading),
            ),
            SeletorCategoriaCateg(),
            // _tituloDestaques(context),
            SizedBox(height: 5.0),
            _caroulselDestaques(context),
            SizedBox(height: 5.0),
            //_tituloCategorias(),
            //SizedBox(height: 10.0),
            //_seletorCategoria(),
            //SizedBox(height: 20.0),
            // _tituloMaisPedidos(context),
            //SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.thLarge,
                        color: !tipoLista
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyText1.color),
                    onPressed: () => setState(() => tipoLista = false)),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.thList,
                      color: tipoLista
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyText1.color,
                    ),
                    onPressed: () => setState(() => tipoLista = true)),
              ],
            ),
            Observer(builder: (_) {
              if (_controller.listProds == null ||
                  _controller.listProds?.length == 0) return Container();

              return tipoLista
                  ? listaProdutos(context, _controller.listProds)
                  : gridProdutos(context, _controller.listProds);
            }),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget listaProdutos(BuildContext context, List<ProdutoModel> lista) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: lista.map((e) => CardProduto(prod: e)).toList(),
    );
  }

  Widget _caroulselDestaques(BuildContext context) {
    return Observer(builder: (_) {
      if (_controller.listDestaques == null ||
          _controller.listDestaques?.length == 0) {
        return Container();
      }
      return CarouselSlider(
        options: CarouselOptions(
          // original era 0.416
          height: MediaQuery.of(context).size.height * 0.37,
          autoPlayCurve: Curves.easeInOut,
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          // aspectRatio: 2.0,
        ),
        items:
            _controller.listDestaques.map((e) => SliderItem(prod: e)).toList(),
        // onPageChanged: (index) {
        //   setState(() {
        //     _current = index;
        //   });
        // },
      );
    });
  }
}
