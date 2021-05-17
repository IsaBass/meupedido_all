import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/modules/altera_adicional/altera_adic_controller.dart';
import 'package:meupedido_core/meupedido_core.dart';

class FormAlteraAdicional extends StatefulWidget {
  final AdicionalGrpModel grupo;

  const FormAlteraAdicional({Key key, this.grupo}) : super(key: key);

  @override
  _FormAlteraAdicionalState createState() => _FormAlteraAdicionalState();
}

class _FormAlteraAdicionalState
    extends ModularState<FormAlteraAdicional, AlteraAdicController> {
  ///
  final TextEditingController _grupoCont = TextEditingController();

  @override
  void initState() {
    super.initState();

    _grupoCont.text = widget.grupo.descricao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grupo.descricao),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              controller.saveGrupoAdic(widget.grupo);
              Modular.to.pop();
            },
          )
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {},
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              child: Column(
            children: [
              exibeCarregandoLinha(isLoading: controller.isLoading),
              DefaultTextFormField(
                textController: _grupoCont,
                hintText: 'Título do grupo',
                labelText: 'Título do grupo',
                onchanged: (v) => widget.grupo.descricao = v,
              ),
              SizedBox(height: 10),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(), //.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _rowQuantidade(widget.grupo, 'Min', 'Quant. Mínima:'),
                    _rowQuantidade(widget.grupo, 'Max', 'Quant. Máxima:'),
                  ],
                ),
              ),
              SizedBox(height: 8),
              ListView(
                shrinkWrap: true,
                children:
                    widget.grupo.adics.map((ad) => _listTile(ad)).toList(),
              ),
              SizedBox(height: 65),
            ],
          )),
        ),
      ),
    );
  }

  Widget _listTile(AdicionalModel ad) {
    final TextEditingController _adCont = TextEditingController();
    final TextEditingController _precoCont = TextEditingController();
    _adCont.text = ad.descricao;
    _precoCont.text = ad.preco.toStringAsFixed(2);

    return Card(
      child: ListTile(
        title: Container(
          height: 60,
          // width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  //width: 20,
                  child: DefaultTextFormField(
                    textController: _adCont,
                    hintText: 'Opcional',
                    labelText: 'Descrição',
                    onchanged: (v) => ad.descricao = v,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 80,
                child: DefaultTextFormField(
                  textController: _precoCont,
                  keyboarType: TextInputType.numberWithOptions(decimal: true),
                  //hintText: 'Preço',
                  labelText: 'Preço',
                  onchanged: (v) => ad.preco = double.parse(v),
                ),
              ),
            ],
          ),
        ),
        subtitle: Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Switch(
                    value: ad.checked,
                    onChanged: (v) => setState(() => ad.checked = v),
                  ),
                  Text('Ativo'),
                ],
              ),
              FlatButton(
                child: Text('EXCLUIR'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowQuantidade(AdicionalGrpModel grupo, String maxMin, String label) {
    return Container(
      // width: double.infinity,
      child: Column(
        children: [
          Text(label),
          Container(
            height: 35,
            child: Row(
              //
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              //
              children: [
                IconButton(
                    icon: Icon(Icons.remove_circle_outline, size: 20),
                    onPressed: () => setState(() {
                          if (maxMin == 'Max') {
                            if (grupo.maxQtd > 0) grupo.maxQtd--;
                          }
                          if (maxMin == 'Min') {
                            if (grupo.minQtd > 0) grupo.minQtd--;
                          }
                        })),
                Text(
                  maxMin == 'Max'
                      ? '${grupo.maxQtd.toStringAsFixed(0)}'
                      : '${grupo.minQtd.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    icon: Icon(Icons.add_circle_outline, size: 20),
                    onPressed: () => setState(() {
                          if (maxMin == 'Max') {
                            grupo.maxQtd++;
                          }
                          if (maxMin == 'Min') {
                            grupo.minQtd++;
                          }
                        })),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
