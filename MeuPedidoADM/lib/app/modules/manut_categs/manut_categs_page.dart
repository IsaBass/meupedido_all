import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'manut_categs_controller.dart';
import 'manut_categs_module.dart';

class ManutCategsPage extends StatefulWidget {
  final String title;
  const ManutCategsPage({Key key, this.title = "ManutCategs"})
      : super(key: key);

  @override
  _ManutCategsPageState createState() => _ManutCategsPageState();
}

class _ManutCategsPageState extends State<ManutCategsPage> {
  //
  final ManutCategsController _controller = ManutCategsModule.to.get();

  @override
  void initState() {
    super.initState();
    _controller.recarregaAllCategs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        // actions: [_menuPequeno()],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Observer(
            builder: (_) =>
                exibeCarregandoLinha(isLoading: _controller.isLoading),
          ),
          // Observer(
          //   builder: (_) =>
          //       _controller.isEditing ? Container() : SeletorCategoriaManut(),
          // ),
          Flexible(child: _painelLista(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _criarNovaCategoria,
      ),
    );
  }

  Widget _painelLista(BuildContext context) {
    return Observer(builder: (_) {
      return _controller.categs == null || _controller.categs.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: _controller.categs
                  .map((categ) => ListTile(
                        title: Text(categ.descricao),
                        leading: Icon(
                          getIconCategoria(categ.icone),
                          color: categ.ativo == true
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).disabledColor,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () async {
                          await Modular.link
                              .pushNamed('/edit', arguments: {"categ": categ});
                          setState(() {});
                        },
                      ))
                  .toList(),
            );
    });
  }

  Future<void> _criarNovaCategoria() async {
    ////
    int prox = 1;
    if (_controller.categs.length > 0) {
      _controller.categs.sort((a, b) => a.codCateg.compareTo(b.codCateg));
      prox = _controller.categs.last.codCateg + 1;
    }

    ///
    var newC = CategoriaModel(
      codCateg: prox,
      descricao: '',
      grupoAdicionais: [],
      // docRef: null,
      icone: '06',
      img: '',
      imgTipo: 'EXT',
      logoPeq: '',
      tipoLogoPeq: '',
    );

    ///
    await Modular.link.pushNamed('/edit', arguments: {"categ": newC});
    setState(() {});

    ///
  }
}
