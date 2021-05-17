import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    getDocs();
  }

  Future<List<Map>> getDocs() async {
    var docs = await Firestore.instance.collection('CNPJS').getDocuments();

    List<Map> list = [];

    list.addAll(docs.documents.map((e) => e.data));

    return list;
  }

  String token;

  @override
  Widget build(BuildContext context) {
    //
    AppModule.to.get<FCMFirebase>().inicializeFCM(context);
    //

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () => Modular.to.pushNamed('/configs'),
                child: Text('Configurações'),
                color: Colors.greenAccent,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () => Modular.to.pushNamed('/categs'),
              child: Text('Categorias'),
              color: Colors.orangeAccent,
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () => Modular.to.pushNamed('/prods'),
              child: Text('Produtos'),
              color: Colors.orangeAccent,
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () async {
                token = await AppModule.to.get<FCMFirebase>().getToken();
                setState(() {
                  print(token);
                });
              },
              child: Text('TOKEN'),
              color: Colors.orangeAccent,
            ),
            SizedBox(height: 20),
            Text(token ?? ''),
            SizedBox(height: 40),
            FutureBuilder<List<Map>>(
                future: getDocs(),
                builder: (_, snap) {
                  if (!snap.hasData)
                    return (Center(child: CircularProgressIndicator()));

                  return Column(
                    children: snap.data.map((e) => Text(e['docId'])).toList(),
                  );
                }),
          ],
        ));
  }
}
