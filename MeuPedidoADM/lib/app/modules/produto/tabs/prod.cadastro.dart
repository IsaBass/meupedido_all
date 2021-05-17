import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import '../produto_controller.dart';
import '../produto_module.dart';

class ProdTabCadastro extends StatefulWidget {
  final GlobalKey<FormState> formCadKey;

  final TextEditingController nomeCont;
  final TextEditingController descritCont;
  final TextEditingController precoCont;
  final ProdutoModel prod;

  const ProdTabCadastro(
      {Key key,
      this.formCadKey,
      this.nomeCont,
      this.descritCont,
      this.precoCont,
      this.prod})
      : super(key: key);

  @override
  _ProdTabCadastroState createState() => _ProdTabCadastroState();
}

class _ProdTabCadastroState extends State<ProdTabCadastro> {
  final ProdutoController _controller = ProdutoModule.to.get();

  @override
  Widget build(BuildContext context) {
    var prod = widget.prod;
    return Form(
      key: widget.formCadKey,
      autovalidate: true,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            SizedBox(height: 2),
            _editNome(prod),
            SizedBox(height: 7),
            _editPrecoAtual(),
            SizedBox(height: 5),
            Card(child: _selecaoDestaque()),
            SizedBox(height: 5),
            _editDescritivo(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _fotoProduto(context),
              ),
            ),
            _cardAtivo(prod),
            SizedBox(height: 10),
            Container(height: 55, child: _botaoSalvar()),
          ],
        ),
      ),
    );
  }

  Card _cardAtivo(ProdutoModel prod) {
    return Card(
      child: SwitchListTile(
        title: Text('Produto Ativo'),
        value: prod.ativo ?? false,
        onChanged: (b) => setState(() => prod.ativo = b),
      ),
    );
  }

  Padding _editNome(ProdutoModel prod) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DefaultTextFormField(
        textController: widget.nomeCont,
        keyboarType: TextInputType.text,
        // iconData: Icons.person,
        hintText: 'nome do produto',
        labelText: 'Descrição do Produto*',
        //helperText: 'seu -email cadastrado',
        validator: (v) {
          if (!(v.length >= 3)) return 'nome muito curto';
          return null;
        },
        onchanged: (v) => prod.descricao = widget.nomeCont.text,
        onsubmitted: (v) => prod.descricao = widget.nomeCont.text,
      ),
    );
  }

  Padding _editPrecoAtual() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DefaultTextFormField(
        textController: widget.precoCont,
        keyboarType: TextInputType.numberWithOptions(decimal: true),
        labelText: 'Preço Atual*',
      ),
    );
  }

  Widget _editDescritivo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Texto descritivo do Produto:'),
            SizedBox(height: 5),
            TextFormField(
              controller: widget.descritCont,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(), // const UnderlineInputBorder(),
                filled: true,
                hintText: 'descritivo',
                labelText: 'Texto descritivo*',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _selecaoDestaque() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Produto em Destaque:'),
          SizedBox(height: 5),
          Container(
            height: 27,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Categoria:'),
                Switch(
                  value: widget.prod.destaqueCateg,
                  onChanged: (b) =>
                      setState(() => widget.prod.destaqueCateg = b),
                ),
                Text('Geral:'),
                Switch(
                  value: widget.prod.destaqueGeral,
                  onChanged: (b) =>
                      setState(() => widget.prod.destaqueGeral = b),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fotoProduto(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
          child: Text('Foto Ilustrativa do Produto:'),
        ),
        Center(
          child: GestureDetector(
            child: Container(
                //width: 140.0,
                height: 140.0,
                child: agImageProvider(
                  imgTipo: widget.prod.imgTipo ?? 'EXT',
                  imgUrl: widget.prod.img ?? '',
                  fit: BoxFit.cover,
                )),
            onTap: () async {
              ///
              await showOptionsFotoCadastro(
                ctx: context,
                inicioArquivo:
                    (widget.prod.codigo ?? widget.prod.descricao) + '123',
                onSimExcluir: () => setState(() => widget.prod.img = ''),
                onNovoArquivo: (novaUrl) {
                  if (novaUrl == null || novaUrl.isEmpty) return;
                  //
                  setState(() {
                    widget.prod.img = novaUrl;
                    widget.prod.imgTipo = 'EXT';
                  });
                  return;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _botaoSalvar() {
    return Container(
      margin: EdgeInsets.all(5),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () async {
          //
          if (!widget.formCadKey.currentState.validate()) return;

          widget.prod.precoAtual = double.parse(widget.precoCont.text);
          widget.prod.descritivo = widget.descritCont.text;
          await _controller.saveProd(widget.prod);

          Modular.to.pop();
          //
        },
        child: Text('Salvar'),
        color: Theme.of(context).primaryColor,
        textColor: Theme.of(context).primaryTextTheme.headline6.color,
      ),
    );
  }
}
