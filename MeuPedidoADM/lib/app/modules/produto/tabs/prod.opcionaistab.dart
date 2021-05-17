import 'package:flutter/material.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'painel.adicionais.dart';

class ProdTabOpcionais extends StatefulWidget {
  final ProdutoModel prod;

  const ProdTabOpcionais({Key key, this.prod}) : super(key: key);
  @override
  _ProdTabOpcionaisState createState() => _ProdTabOpcionaisState();
}

class _ProdTabOpcionaisState extends State<ProdTabOpcionais> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            PainelAdicional(
              grupoAdicionais: widget.prod.grupoAdicionais,
              //atualizeAlgo: _controller.updFalso
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
