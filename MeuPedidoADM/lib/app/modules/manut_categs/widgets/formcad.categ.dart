import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import '../manut_categs_controller.dart';
import '../manut_categs_module.dart';

class CadCategForm extends StatefulWidget {
  final CategoriaModel categ;

  CadCategForm({Key key, this.categ}) : super(key: key);

  @override
  _CadCategFormState createState() => _CadCategFormState();
}

class _CadCategFormState extends State<CadCategForm>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nomeCont = TextEditingController();
  final formCadKey = GlobalKey<FormState>();
  final ManutCategsController _controller = ManutCategsModule.to.get();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _nomeCont.text = widget.categ.descricao;
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categ.descricao),
        actions: [_menuPequeno()],
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //automaticallyImplyLeading: false,
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
                SingleChildScrollView(child: _formCadastro(context)),
                Container(color: Colors.green),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(height: 55, child: _botaoSalvar()),
    );
  }

  Form _formCadastro(BuildContext context) {
    return Form(
      key: formCadKey,
      autovalidate: true,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            DefaultTextFormField(
              textController: _nomeCont,
              keyboarType: TextInputType.text,
              // iconData: Icons.person,
              hintText: 'nome da categoria',
              labelText: 'Descrição Categoria*',
              //helperText: 'seu -email cadastrado',
              validator: (v) {
                if (!(v.length >= 3)) return 'nome muito curto';
                return null;
              },
              onchanged: (v) => widget.categ.descricao = _nomeCont.text,
              onsubmitted: (v) => widget.categ.descricao = _nomeCont.text,
            ),
            SizedBox(height: 7),
            _iconePadrao(),
            SizedBox(height: 10),
            Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _fotoCategoria(context),
            )),
            Card(
              child: SwitchListTile(
                title: Text('Categoria Ativa'),
                value: widget.categ.ativo ?? false,
                onChanged: (b) => setState(() => widget.categ.ativo = b),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _botaoSalvar() {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          if (!formCadKey.currentState.validate()) return;

          await _controller.updateCateg(widget.categ);

          Modular.to.pop();
        },
        child: Text('Salvar'),
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryTextTheme.headline6.color,
      ),
    );
  }

  Container _iconePadrao() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ícone Padrão'),
          Center(
            child: DropdownButton(
              elevation: 0,
              value: widget.categ?.icone ?? '',
              items: categoriesIcons
                  .map((ic) => DropdownMenuItem(
                        child: Row(
                          children: [
                            Icon(ic['icon']),
                            SizedBox(width: 10),
                            Text(ic['descricao']),
                          ],
                        ),
                        value: ic['cod'],
                      ))
                  .toList(),
              onChanged: (v) => setState(() => widget.categ.icone = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fotoCategoria(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Text('Figura Padrão:'),
        ),
        Center(
          child: GestureDetector(
            child: Container(
                width: 140.0,
                height: 140.0,
                child: ClipOval(
                  // clipper: ,
                  child: agImageProvider(
                    imgTipo: widget.categ?.imgTipo ?? 'EXT',
                    imgUrl: widget.categ.img ?? '',
                    fit: BoxFit.cover,
                  ),
                )),
            onTap: () async {
              //  showOptionsFotoCadastro(context);
              await showOptionsFotoCadastro(
                ctx: context,
                inicioArquivo: widget.categ.codCateg.toString(),
                onSimExcluir: () {
                  setState(() {
                    return widget.categ.img = '';
                  });
                  // _controller.saveUserData(alterarLoading: true);
                },
                onNovoArquivo: (novaUrl) {
                  if (novaUrl == null || novaUrl.isEmpty) return;
                  //
                  setState(() {
                    widget.categ.img = novaUrl;
                    widget.categ.imgTipo = 'EXT';
                  });
                  //_controller.saveUserData(alterarLoading: true);
                  return;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  PopupMenuButton<String> _menuPequeno() {
    return PopupMenuButton(
        onSelected: (value) {
          // if (value == 'NEW') {
          //   _criarNovaCategoria();
          //   return;
          // }

          if (value == 'EXC') {
            _excluirCategoria(widget.categ);
            return;
          }
        },
        itemBuilder: (_) => [
              //PopupMenuItem(value: 'NEW', child: Text('Nova Categoria')),
              PopupMenuItem(value: 'EXC', child: Text('Excluir')),
            ]);
  }

  void _excluirCategoria(CategoriaModel categ) async {
    ////
    // VERIFICAR SE POSSUI PRODUTO NA CATEGORIA
    var existe = await _controller.existeProdCateg(categ);
    if (existe) {
      await showPergunta(
        context: context,
        title: 'Impossível',
        desc: 'Categoria não pode ser excluída.\nPossui produtos.',
        botaoSim: '',
      );
      return;
    }

    // PERGUNTAR AQUI
    await showPergunta(
      context: context,
      title: 'Confirma a exclusão?',
      desc: 'Confirma a exclusão permanente dessa categoria?',
      botaoSim: 'Excluir',
      funcSim: () {
        _controller.excluirCateg(categ);
        Modular.to.pop();
      },
    );
    ///
  }
}
