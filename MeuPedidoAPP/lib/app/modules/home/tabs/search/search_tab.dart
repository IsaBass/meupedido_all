import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'search_controller.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends ModularState<SearchTab, SearchController> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
Text('SEARCH TAB'),
    ],);
  }
}

/*
Scaffold(
      body: Column(
        children: [
          Text('TAB SEARCH'),
          Container(
            padding: EdgeInsets.all(10),
            //color: Colors.blue,
            child: TextFormField(
              // controller: widget.textController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.search),
                hintText: 'pesquise aqui',
                //labelText: 'aqui o label',
                //helperText: 'widget.helperText',
              ),
              onChanged: (v) {
                if (v.length > 3) {
                  controller.buscaProduto(v);
                }
              },
            ),
          ),
          Expanded(
            child: Observer(builder: (_) {
              if (controller.isLoading) {
                return Center(
                    child: exibeCarregandoCircular(
                  isLoading: controller.isLoading,
                ));
              }
              if (controller.prods == null || controller.prods.length == 0) {
                return Center(child: Text('Sem produtos a exibir.'));
              }

              return ListView(
                primary: false,
                shrinkWrap: true,
                children:
                    controller.prods.map((e) => CardProduto(prod: e)).toList(),
              );
            }),
          ),
        ],
      ),
    );
*/
