import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<bool> showPergunta(
    {String desc,
    @required String title,
    String botaoSim = 'CONFIRMA',
    String botaoNao = 'VOLTAR',
    @required BuildContext context,
    Function funcSim}) async {
  var resp = false;

  List<DialogButton> botoes = [ DialogButton(
        child: Text(
          botaoNao,
          style: TextStyle(color: Theme.of(context).accentTextTheme.bodyText2.color, fontSize: 20),
        ),
        //color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
          resp = false;
        },
        width: 120,
      )

  ];

  if(botaoSim != '') {
    botoes.add(DialogButton(
        width: 120,
        child: Text(
          botaoSim,
          style: TextStyle(color: Theme.of(context).accentTextTheme.bodyText2.color, fontSize: 20),
        ),
        //color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
          if (funcSim != null) {
            funcSim();
          }
          resp = true;
        },
      ));
  }

  await Alert(
    context: context,
    type: AlertType.warning,
    title: title,
    desc: desc,
    buttons: botoes,
  ).show();

  return resp;
}
