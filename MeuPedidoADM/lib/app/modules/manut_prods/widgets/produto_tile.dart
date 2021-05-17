import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

class ProdutoTile extends StatefulWidget {
  final ProdutoModel prod;
  final String idCateg;

  const ProdutoTile({Key key, this.prod, this.idCateg}) : super(key: key);

  @override
  _ProdutoTileState createState() => _ProdutoTileState();
}

class _ProdutoTileState extends State<ProdutoTile> {
  @override
  Widget build(BuildContext context) {
    //  print('build do prod  ${widget.prod.descricao} ');
    return Card(
      child: ListTile(
        title: Text(widget.prod.descricao),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            await Modular.to
                .pushNamed('/prod', arguments: {"prod": widget.prod, "idCateg": widget.idCateg});
            setState(() {});
          },
        ),
        subtitle: !widget.prod.ativo
            ? Container(
                height: 30,
                child: Row(
                  children: [
                    Icon(Icons.block, color: Colors.grey, size: 20),
                    SizedBox(width: 5),
                    Text('Produto Inativo')
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('R\$ ${widget.prod.precoAtual.toStringAsFixed(2)}'),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.only(top: 5, bottom: 2),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 30,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Categ:'),
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
      ),
    );
  }
}
